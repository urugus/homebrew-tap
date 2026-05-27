cask "pullbell" do
  version "0.7.1"

  on_arm do
    sha256 "8d743085b44761b5d433a595213371e39394d2d1058664173898beb5d69eb374"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-aarch64-apple-darwin.zip"
  end

  on_intel do
    sha256 "923b7afd79d527f60fd390ef41c7ff3c2ba8d0573c4fdbcab31363567f3b0c37"
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
