cask "nextroom" do
  version "0.1.39"
  sha256 "04c765318fd88739f0af2e334821617db4c75a88be8edb3dc56684317f68b677"

  url "https://github.com/urugus/nextroom/releases/download/v#{version}/NextRoom-#{version}-mac-arm64.zip"
  name "NextRoom"
  desc "Google Calendar linked Google Meet launcher for macOS"
  homepage "https://github.com/urugus/nextroom"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "NextRoom.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/NextRoom.app"]
  end
end
