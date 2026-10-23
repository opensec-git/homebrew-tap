# OpenSec Homebrew tap

Homebrew formulae for [Pi-Bolt](https://github.com/opensec-git/Pi-Bolt), the Pi coding agent compiled ahead of time to native
code.

## Install

```bash
brew install opensec-git/tap/pi-bolt
```

This installs the latest Pi-Bolt release and puts `pi-bolt` on PATH. It runs on macOS on Apple silicon, Linux x86-64 (CPUs with
AVX2) and Linux ARM64. Intel Macs are not supported.

## Upgrade

```bash
brew upgrade pi-bolt
```

`pi-bolt update` does not replace a Homebrew installation: it tells you to run `brew upgrade pi-bolt`.

## Uninstall

```bash
brew uninstall pi-bolt
brew untap opensec-git/tap
```

Your sessions and settings in `~/.pi` stay.

## Other ways to install

The installer (`curl -fsSL https://pi-bolt.opensec.in/install.sh | sh`), the npm package and the Windows installer are described
in [Pi-Bolt's installation guide](https://pi-bolt.opensec.in/docs/installation.html). The installer also offers the JIT build
and the x86-64 build for CPUs without AVX2, which this formula does not.

## How the formula is updated

Pi-Bolt's release workflow rewrites `Formula/pi-bolt.rb` (version, URLs and SHA-256 checksums, from the release's signed
`SHA256SUMS`) and pushes it here when a release is published.
