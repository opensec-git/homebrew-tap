# Pi-Bolt's release archives, as the installer (https://pi-bolt.opensec.in/install.sh) unpacks them: the folder holds the
# executable `pi` and the files it reads beside it (docs, themes, native modules), so it is installed whole into libexec and
# `pi-bolt` links to `pi` there. Pi-Bolt's release workflow rewrites the version, URLs and checksums for each release.
class PiBolt < Formula
  desc "Pi coding agent, compiled ahead of time to native code"
  homepage "https://pi-bolt.opensec.in"
  version "1.0.0"
  license "MIT"

  on_macos do
    # Apple silicon only: there is no build for Intel Macs.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.0/pi-bolt-darwin-arm64.tar.gz"
      sha256 "d5aa5bcc4eb5f1d79f8ce63f3c24b837f34d19cd394a637f1abe781db422f3d7"
    end
  end

  on_linux do
    on_intel do
      # The default x86-64 build, for CPUs with AVX2.
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.0/pi-bolt-linux-x64.tar.gz"
      sha256 "a364334fd3888b391ba1f84710cc933541d3bcd066f0bd595b9daf040687c50e"
    end
    on_arm do
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.0/pi-bolt-linux-arm64.tar.gz"
      sha256 "838369d20ea47ff35423b3de4d4d74ac0fd894f61944090d23ac911ca7a08635"
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
