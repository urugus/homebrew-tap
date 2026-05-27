class Pullbell < Formula
  desc "macOS menu bar app for GitHub pull request notifications"
  homepage "https://github.com/urugus/Pullbell"
  url "https://github.com/urugus/Pullbell/archive/refs/tags/v0.7.1.tar.gz"
  version "0.7.1"
  sha256 "e17c9d8b10ee4b29482c9ef4c61503b16026acfed59f1c5e062219cb49358c88"
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
