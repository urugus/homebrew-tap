class Pullbell < Formula
  desc "macOS menu bar app for GitHub pull request notifications"
  homepage "https://github.com/urugus/Pullbell"
  url "https://github.com/urugus/Pullbell/archive/refs/tags/v0.9.3.tar.gz"
  version "0.9.3"
  sha256 "6d9a38e157f245d84901718c7bf9d3d9885bfa7fb43bb79b0c8262c4d2d860f8"
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
