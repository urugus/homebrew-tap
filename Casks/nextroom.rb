cask "nextroom" do
  version "0.1.23"
  sha256 "0777b26afec122e6c4ab7bee45d0a70af28fa0926d6e64af1b04abbb30689897"

  url "https://github.com/urugus/nextroom/releases/download/v#{version}/NextRoom-#{version}-mac-arm64.zip"
  name "NextRoom"
  desc "Google Calendar linked Google Meet launcher for macOS"
  homepage "https://github.com/urugus/nextroom"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "NextRoom.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/NextRoom.app"]
  end
end
