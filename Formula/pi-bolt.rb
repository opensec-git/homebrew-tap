# Pi-Bolt's release archives, as the installer (https://pi-bolt.opensec.in/install.sh) unpacks them:
# the folder holds the executable `pi` and the files it reads beside it (docs, themes, native modules),
# so it is installed whole into libexec and `pi-bolt` links to `pi` there. Pi-Bolt's release workflow
# rewrites the version, URLs and checksums for each release.
class PiBolt < Formula
  desc "Pi coding agent, compiled ahead of time to native code"
  homepage "https://pi-bolt.opensec.in"
  # macOS: Apple silicon's build. (Not in an on_arm block: an Intel Mac would then find no URL,
  # and fail with a less clear error than the requirement below.)
  url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.3.2/pi-bolt-darwin-arm64.tar.gz"
  version "1.3.2"
  sha256 "3d818f2a783e6af44079810dbf079c2feeb9ceb47abb4f0951e0329c96289658"
  license "MIT"

  on_macos do
    # There is no build for Intel Macs.
    depends_on arch: :arm64
  end

  on_linux do
    on_intel do
      # The default x86-64 build, for CPUs with AVX2.
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.3.2/pi-bolt-linux-x64.tar.gz"
      sha256 "cbb3896d4379fe94b2929b64c7252a260c7fcd49984724b390ab45156e86bd98"
    end
    on_arm do
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.3.2/pi-bolt-linux-arm64.tar.gz"
      sha256 "95e37f5da2887578e8358330d8513ac6c7f1d095379563647755bfd1541f320b"
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
