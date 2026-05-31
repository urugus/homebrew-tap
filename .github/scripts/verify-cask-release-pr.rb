#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "base64"
require "json"
require "open-uri"
require "open3"

def abort_with(message)
  warn "release PR verification failed: #{message}"
  exit 1
end

def git(*args)
  output, status = Open3.capture2e("git", *args)
  abort_with("git #{args.join(' ')} failed:\n#{output}") unless status.success?

  output
end

def gh_api(path)
  output, status = Open3.capture2e("gh", "api", path)
  abort_with("gh api #{path} failed:\n#{output}") unless status.success?

  output
end

if ENV["PR_NUMBER"] && ENV["REPOSITORY"] && ENV["HEAD_SHA"]
  pr_number = ENV.fetch("PR_NUMBER")
  repository = ENV.fetch("REPOSITORY")
  head_sha = ENV.fetch("HEAD_SHA")

  files = JSON.parse(gh_api("repos/#{repository}/pulls/#{pr_number}/files?per_page=100"))
  changed_files = files.map { |file| file.fetch("filename") }
else
  base_ref = ENV.fetch("BASE_REF", "origin/main")
  diff_range = "#{base_ref}...HEAD"
  changed_files = git("diff", "--name-only", diff_range).lines.map(&:strip).reject(&:empty?)
end

unless changed_files.length == 1
  abort_with("expected exactly one changed file, got #{changed_files.length}: #{changed_files.join(', ')}")
end

cask_path = changed_files.first
unless cask_path.match?(%r{\ACasks/[A-Za-z0-9._-]+\.rb\z})
  abort_with("expected a single cask file change, got #{cask_path}")
end

if files
  patch = files.first.fetch("patch") { abort_with("GitHub API did not include a patch for #{cask_path}") }
  content = JSON.parse(gh_api("repos/#{repository}/contents/#{cask_path}?ref=#{head_sha}"))
  cask = Base64.decode64(content.fetch("content"))
else
  patch = git("diff", "--unified=0", "--no-ext-diff", diff_range, "--", cask_path)
  cask = File.read(cask_path)
end

changed_lines = patch.lines.select do |line|
  (line.start_with?("+") || line.start_with?("-")) &&
    !line.start_with?("+++") &&
    !line.start_with?("---")
end

allowed_line = /\A[+-]  (version "[^"]+"|sha256 "[0-9a-f]{64}")\n?\z/
unexpected_lines = changed_lines.reject { |line| line.match?(allowed_line) }
unless unexpected_lines.empty?
  abort_with("only version and sha256 lines may change:\n#{unexpected_lines.join}")
end

added_versions = changed_lines.grep(/\A\+  version "/)
removed_versions = changed_lines.grep(/\A-  version "/)
added_sha256s = changed_lines.grep(/\A\+  sha256 "/)
removed_sha256s = changed_lines.grep(/\A-  sha256 "/)

unless added_versions.length == 1 && removed_versions.length == 1 &&
       added_sha256s.length == 1 && removed_sha256s.length == 1
  abort_with("expected exactly one version line and one sha256 line to be updated")
end

version = cask[/^\s*version "([^"]+)"/, 1]
sha256 = cask[/^\s*sha256 "([0-9a-f]{64})"/, 1]
url_template = cask[/^\s*url "([^"]+)"/, 1]

abort_with("could not read version from #{cask_path}") unless version
abort_with("could not read sha256 from #{cask_path}") unless sha256
abort_with("could not read url from #{cask_path}") unless url_template

url = url_template.gsub('#{version}', version)
unless url.start_with?("https://github.com/")
  abort_with("release asset URL must be hosted on GitHub: #{url}")
end

digest = Digest::SHA256.new
URI.open(url, "rb", read_timeout: 60) do |io|
  while (chunk = io.read(1024 * 1024))
    digest.update(chunk)
  end
end

actual_sha256 = digest.hexdigest
unless actual_sha256 == sha256
  abort_with("sha256 mismatch for #{url}: expected #{sha256}, got #{actual_sha256}")
end

puts "Verified #{cask_path} #{version}: #{sha256}"
