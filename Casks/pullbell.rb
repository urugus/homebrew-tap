cask "pullbell" do
  version "0.9.2"

  on_arm do
    sha256 "63c0f1be33894674645c0fd06c7f25cc5c6a12b316cb1dcd7f7f1183781c6df8"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-aarch64-apple-darwin.zip"
  end

  on_intel do
    sha256 "0c698656567d8c62f253034dbdc7f33049b86902715252c4a996fb14a07c3088"
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
