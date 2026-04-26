class Baseline < Formula
  desc "Read-only CLI for IssueHunt Baseline"
  homepage "https://github.com/urugus/baseline-cli"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/urugus/baseline-cli/releases/download/v0.2.0/baseline-darwin-arm64"
      sha256 "58e79397203e48b810d2730209b2356ca680ce35c8d77449a17a3e855120e0e5"
    else
      url "https://github.com/urugus/baseline-cli/releases/download/v0.2.0/baseline-darwin-amd64"
      sha256 "89eea9592367e9164b97b7b56e39d834482c6201915cee685592f24b4aa04104"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/urugus/baseline-cli/releases/download/v0.2.0/baseline-linux-arm64"
      sha256 "f0fe3f0868ad13be399f7f44ff7f2704cd097ee457107958529844d99cf8431b"
    else
      url "https://github.com/urugus/baseline-cli/releases/download/v0.2.0/baseline-linux-amd64"
      sha256 "54ddc326aa429e76fb354767d46d98852bbba71f501c17e5172a37c3a86b2b28"
    end
  end

  def install
    bin.install Dir["baseline-*"].first => "baseline"
  end

  test do
    assert_match "baseline v0.2.0", shell_output("#{bin}/baseline version")
  end
end
