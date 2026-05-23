cask "pullbell" do
  version "0.4.1"

  on_arm do
    sha256 "9e28dbdd6828ccb86309352e84bc3f2a523ccfcc5ec8effbe72b9434fc4cd3aa"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-aarch64-apple-darwin.zip"
  end

  on_intel do
    sha256 "ac2eeb6afc34cf8f1ca275b79ff013a5346c862d11d626f60235576f1c0106cb"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-x86_64-apple-darwin.zip"
  end

  name "Pullbell"
  desc "macOS menu bar app for GitHub pull request notifications"
  homepage "https://github.com/urugus/Pullbell"

  app "Pullbell.app"

  depends_on macos: ">= :monterey"
end
