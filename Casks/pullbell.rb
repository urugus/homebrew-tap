cask "pullbell" do
  version "0.3.0"

  on_arm do
    sha256 "1a5bce406047a47c3d3c4922a1df6817ed24ea5e3809697d32a92d274bb5f778"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-aarch64-apple-darwin.zip"
  end

  on_intel do
    sha256 "85f0ee108ae1f7708c44b7019cfaff564c736b30bf076cb17e2568f1ac9d5ed8"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-x86_64-apple-darwin.zip"
  end

  name "Pullbell"
  desc "macOS menu bar app for GitHub pull request notifications"
  homepage "https://github.com/urugus/Pullbell"

  app "Pullbell.app"

  depends_on macos: ">= :monterey"
end
