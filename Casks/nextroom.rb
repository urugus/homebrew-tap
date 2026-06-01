cask "nextroom" do
  version "0.1.18"
  sha256 "1969ab9172eb9054601e96da9e07f84b1d000156b7a66618fb7ba812e92b6abe"

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
