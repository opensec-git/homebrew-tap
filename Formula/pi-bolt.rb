# Pi-Bolt's release archives, as the installer (https://pi-bolt.opensec.in/install.sh) unpacks them:
# the folder holds the executable `pi` and the files it reads beside it (docs, themes, native modules),
# so it is installed whole into libexec and `pi-bolt` links to `pi` there. Pi-Bolt's release workflow
# rewrites the version, URLs and checksums for each release.
class PiBolt < Formula
  desc "Pi coding agent, compiled ahead of time to native code"
  homepage "https://pi-bolt.opensec.in"
  # macOS: Apple silicon's build. (Not in an on_arm block: an Intel Mac would then find no URL,
  # and fail with a less clear error than the requirement below.)
  url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.6/pi-bolt-darwin-arm64.tar.gz"
  version "1.0.6"
  sha256 "3a158b5e07dd6843f0d78ade3921b9f7fcde6969d1700469e2629b9353bf3479"
  license "MIT"

  on_macos do
    # There is no build for Intel Macs.
    depends_on arch: :arm64
  end

  on_linux do
    on_intel do
      # The default x86-64 build, for CPUs with AVX2.
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.6/pi-bolt-linux-x64.tar.gz"
      sha256 "cf9a4c458d57dbe6f8f793388785d5d08f85356fcf285d65e3180033deaaadaa"
    end
    on_arm do
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.6/pi-bolt-linux-arm64.tar.gz"
      sha256 "141365e626eec5017e251d6ca70d7ca31cae30bc466657f449e326ff61dc16be"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"pi" => "pi-bolt"
  end

  test do
    assert_match "Pi-Bolt #{version},", shell_output("#{bin}/pi-bolt --version")
  end
end
