class Baseline < Formula
  desc "Read-only CLI for IssueHunt Baseline"
  homepage "https://github.com/urugus/baseline-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/urugus/baseline-cli/releases/download/v0.1.0/baseline-darwin-arm64"
      sha256 "8a5bb40f646c8375e9f2a0cd9123d87bde96727af56c95e7afad561ccb913cad"
    else
      url "https://github.com/urugus/baseline-cli/releases/download/v0.1.0/baseline-darwin-amd64"
      sha256 "d9ae60c17121f15acfdf3d75763c10523c7dbfb6b2d4ff398ad33d0a860d6fb6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/urugus/baseline-cli/releases/download/v0.1.0/baseline-linux-arm64"
      sha256 "679bf59ad0e1e3d973368d488ac4727454400de18bacdd5eba89163634a60dfb"
    else
      url "https://github.com/urugus/baseline-cli/releases/download/v0.1.0/baseline-linux-amd64"
      sha256 "bcbe17b4218d6972b87fdf60bb701bf515b13dada82fd99d39c973b11fcf5c86"
    end
  end

  def install
    bin.install Dir["baseline-*"].first => "baseline"
  end

  test do
    assert_match "baseline v0.1.0", shell_output("#{bin}/baseline version")
  end
end
