cask "pullbell" do
  version "0.9.0"

  on_arm do
    sha256 "422ff4b8b0f4623b74dd68fa3320df4a7cc1ceeba6cde6e7fe6bf0b423d03739"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-aarch64-apple-darwin.zip"
  end

  on_intel do
    sha256 "fa2b81ffe89b4e044e0c224bcc64cf182ad490d0e29d2e034e5f764b89ac52ef"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-x86_64-apple-darwin.zip"
  end

  name "Pullbell"
  desc "macOS menu bar app for GitHub pull request notifications"
  homepage "https://github.com/urugus/Pullbell"

  depends_on macos: ">= :monterey"

  app "Pullbell.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Pullbell.app"]
  end
end
