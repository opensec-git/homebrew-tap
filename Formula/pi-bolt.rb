# Pi-Bolt's release archives, as the installer (https://pi-bolt.opensec.in/install.sh) unpacks them:
# the folder holds the executable `pi` and the files it reads beside it (docs, themes, native modules),
# so it is installed whole into libexec and `pi-bolt` links to `pi` there. Pi-Bolt's release workflow
# rewrites the version, URLs and checksums for each release.
class PiBolt < Formula
  desc "Pi coding agent, compiled ahead of time to native code"
  homepage "https://pi-bolt.opensec.in"
  # macOS: Apple silicon's build. (Not in an on_arm block: an Intel Mac would then find no URL,
  # and fail with a less clear error than the requirement below.)
  url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.7/pi-bolt-darwin-arm64.tar.gz"
  version "1.0.7"
  sha256 "555dc9f2627731dfa7bed70ebb4884e3bbc3a7ff9fb714e0b92d95f72d850e5a"
  license "MIT"

  on_macos do
    # There is no build for Intel Macs.
    depends_on arch: :arm64
  end

  on_linux do
    on_intel do
      # The default x86-64 build, for CPUs with AVX2.
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.7/pi-bolt-linux-x64.tar.gz"
      sha256 "d1d416f117f1e36f89145cc5d40f7f64108830f86dbbb691cdc2933bbd8ed39e"
    end
    on_arm do
      url "https://github.com/opensec-git/Pi-Bolt/releases/download/bolt-v1.0.7/pi-bolt-linux-arm64.tar.gz"
      sha256 "f794e8063f1806d0eec6997df825c68b9afb13d50929b00504376c7a3e8a8cd3"
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
