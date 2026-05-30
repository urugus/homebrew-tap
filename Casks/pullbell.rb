cask "pullbell" do
  version "0.9.1"

  on_arm do
    sha256 "303b8e2fe4200d772935e264b26358423c18a684307eaca59fd5e89fbc479ca6"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-aarch64-apple-darwin.zip"
  end

  on_intel do
    sha256 "1268fa144676ac65af0ab097e83149acef9952fa9cfa079586f4b060bfe2aaf5"
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
