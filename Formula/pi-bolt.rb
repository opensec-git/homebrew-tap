# Pi-Bolt's release archives, as the installer (https://pi-bolt.opensec.in/install.sh) unpacks them:
# the folder holds the executable `pi` and the files it reads beside it (docs, themes, native modules),
# so it is installed whole into libexec and `pi-bolt` links to `pi` there. Pi-Bolt's release workflow
# rewrites the version, URLs and checksums for each release.
class PiBolt < Formula
  desc "Pi coding agent, compiled ahead of time to native code"
  homepage "https://pi-bolt.opensec.in"
  # macOS: Apple silicon's build. (Not in an on_arm block: an Intel Mac would then find no URL,
  # and fail with a less clear error than the requirement below.)
  url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.2/pi-bolt-darwin-arm64.tar.gz"
  version "1.0.2"
  sha256 "c2d1e355442f47b42126a5a00580d8d7df18111ee0c82bd4e49756534cf08557"
  license "MIT"

  on_macos do
    # There is no build for Intel Macs.
    depends_on arch: :arm64
  end

  on_linux do
    on_intel do
      # The default x86-64 build, for CPUs with AVX2.
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.2/pi-bolt-linux-x64.tar.gz"
      sha256 "192b29e0f13a243b4d56932d81bee99c77599e06891a668ca46314593f41d2c4"
    end
    on_arm do
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.2/pi-bolt-linux-arm64.tar.gz"
      sha256 "33cbdfd422659874a3eab8a5cdeeae872e877835e2452006161a25fb9cdb48ea"
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
