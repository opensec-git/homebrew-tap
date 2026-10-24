# Pi-Bolt's release archives, as the installer (https://pi-bolt.opensec.in/install.sh) unpacks them:
# the folder holds the executable `pi` and the files it reads beside it (docs, themes, native modules),
# so it is installed whole into libexec and `pi-bolt` links to `pi` there. Pi-Bolt's release workflow
# rewrites the version, URLs and checksums for each release.
class PiBolt < Formula
  desc "Pi coding agent, compiled ahead of time to native code"
  homepage "https://pi-bolt.opensec.in"
  # macOS: Apple silicon's build. (Not in an on_arm block: an Intel Mac would then find no URL,
  # and fail with a less clear error than the requirement below.)
  url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.1/pi-bolt-darwin-arm64.tar.gz"
  version "1.0.1"
  sha256 "4186a0200818c0a1bdcde3919539a5f9eddcb54e923390ab1bb715867d4e15b5"
  license "MIT"

  on_macos do
    # There is no build for Intel Macs.
    depends_on arch: :arm64
  end

  on_linux do
    on_intel do
      # The default x86-64 build, for CPUs with AVX2.
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.1/pi-bolt-linux-x64.tar.gz"
      sha256 "406cfda54f09413159cda9d1c243d46896829b8f5a7d9a8a206e40d8aca129e9"
    end
    on_arm do
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.1/pi-bolt-linux-arm64.tar.gz"
      sha256 "42b72d425eb44049592d220ff936622b535f4d754f742b30e0949c47c1056167"
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
