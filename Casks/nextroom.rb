cask "nextroom" do
  version "0.1.28"
  sha256 "da710a93434ff3ddcd9f7673acbbdf3bf26bde2ed9476dc350bd0000078b4dd0"

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
