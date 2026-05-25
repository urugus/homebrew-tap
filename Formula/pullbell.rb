class Pullbell < Formula
  desc "macOS menu bar app for GitHub pull request notifications"
  homepage "https://github.com/urugus/Pullbell"
  url "https://github.com/urugus/Pullbell/archive/refs/tags/v0.6.0.tar.gz"
  version "0.6.0"
  sha256 "6c5e86210e54e5c45848832fe85afb8788c0ecf5baa2df5656ed6485d2d300a0"
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
