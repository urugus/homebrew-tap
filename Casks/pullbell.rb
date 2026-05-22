cask "pullbell" do
  version "0.4.0"

  on_arm do
    sha256 "e837ba4415c0d20cd9cba2ba75fd921a47af2b5077fd840930a1d227040a1db0"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-aarch64-apple-darwin.zip"
  end

  on_intel do
    sha256 "9c67682734974f7e92ddfb2cff5248d36cf8fd4b01ee27ea3c1425defbd85eda"
    url "https://github.com/urugus/Pullbell/releases/download/v#{version}/pullbell-#{version}-x86_64-apple-darwin.zip"
  end

  name "Pullbell"
  desc "macOS menu bar app for GitHub pull request notifications"
  homepage "https://github.com/urugus/Pullbell"

  app "Pullbell.app"

  depends_on macos: ">= :monterey"
end
