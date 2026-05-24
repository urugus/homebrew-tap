class Pullbell < Formula
  desc "macOS menu bar app for GitHub pull request notifications"
  homepage "https://github.com/urugus/Pullbell"
  url "https://github.com/urugus/Pullbell/archive/refs/tags/v0.4.2.tar.gz"
  version "0.4.2"
  sha256 "736d42ca9a34905840c870c0428b2069ef77c54f385a4074f2998e4a0e3ac732"
  license "MIT"
  head "https://github.com/urugus/Pullbell.git", branch: "main"

  depends_on "rust" => :build
  depends_on macos: :monterey

  def install
    system "cargo", "install", *std_cargo_args(root: libexec)
    system "scripts/package-macos-app.sh", libexec/"bin/pullbell", buildpath/"dist", version

    prefix.install "dist/Pullbell.app"

    (bin/"pullbell").write <<~SH
      #!/bin/bash
      exec /usr/bin/open "#{opt_prefix}/Pullbell.app"
    SH
    chmod 0755, bin/"pullbell"
  end

  def caveats
    <<~EOS
      Pullbell is installed as:
        #{opt_prefix}/Pullbell.app

      Start it with:
        pullbell

      Formula builds do not embed Pullbell's release OAuth client ID. If the app
      asks for one, create a GitHub OAuth App with Device Flow enabled and save
      its client ID:
        mkdir -p ~/.config/pullbell
        printf '%s' 'YOUR_GITHUB_OAUTH_CLIENT_ID' > ~/.config/pullbell/client_id
    EOS
  end

  test do
    assert_path_exists prefix/"Pullbell.app/Contents/MacOS/pullbell"
    assert_predicate prefix/"Pullbell.app/Contents/MacOS/pullbell", :executable?
  end
end
