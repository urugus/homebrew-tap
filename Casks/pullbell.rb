cask "pullbell" do
  version "0.6.0"

  on_arm do
    sha256 "c5796f4f973f4523ed1f80b0f0ddc2aa1153d793d5251f900001718f96dd4525"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-aarch64-apple-darwin.zip"
  end

  on_intel do
    sha256 "d8ed801a1be406b7452f014d60e8d5ab7eddeb68439447908bdfee58033a99cb"
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
