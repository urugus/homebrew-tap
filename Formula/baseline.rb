class Baseline < Formula
  desc "Read-only CLI for IssueHunt Baseline"
  homepage "https://github.com/urugus/baseline-cli"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/urugus/baseline-cli/releases/download/v0.3.0/baseline-darwin-arm64"
      sha256 "87381d251b9731f4bd92e278667cde50044736e4a996a1aefbbd4eacc8b3b935"
    else
      url "https://github.com/urugus/baseline-cli/releases/download/v0.3.0/baseline-darwin-amd64"
      sha256 "e1ba5aa81f095145f43e1521575b2bf542fdd5f77069725898e506557c3d5153"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/urugus/baseline-cli/releases/download/v0.3.0/baseline-linux-arm64"
      sha256 "da657d41fbde8b100a1e02108dc477fa259d9eadf2b056903133fe3605642a43"
    else
      url "https://github.com/urugus/baseline-cli/releases/download/v0.3.0/baseline-linux-amd64"
      sha256 "2a98e2f3acc7fd6ce9b22752dd49507830bc4c97bec08792da5c45cdd5abfbb0"
    end
  end

  def install
    bin.install Dir["baseline-*"].first => "baseline"
  end

  test do
    assert_match "baseline v0.3.0", shell_output("#{bin}/baseline version")
  end
end
