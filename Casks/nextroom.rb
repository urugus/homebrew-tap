cask "nextroom" do
  version "0.1.8"
  sha256 "10d74aff9ba5ce9ce6bf1622a6953c3a87e353647c0bd4b8d10924d28d089e2a"

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
