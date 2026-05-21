cask "pullbell" do
  version "0.2.0"

  on_arm do
    sha256 "6403d979b173011505384f58e3186c65278aa874e472954adff874cf9ef9883d"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-aarch64-apple-darwin.zip"
  end

  on_intel do
    sha256 "04c0e9a3a5cab18606b7461454d8abb32bfb95964eb1e2a6470f36013d073eba"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-x86_64-apple-darwin.zip"
  end

  name "Pullbell"
  desc "macOS menu bar app for GitHub pull request notifications"
  homepage "https://github.com/urugus/Pullbell"

  app "Pullbell.app"

  depends_on macos: ">= :monterey"
end
