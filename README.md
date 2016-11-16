# homebrew-grub
Homebrew tap for installing GNU GRUB.

Note that this currently only works for the `x86_64-pc-elf` target and the HEAD version of GRUB; e.g.:
```
brew install --with-x86_64-pc-elf --HEAD
```
Support for fixed versions and other targets is coming soon.

Building GRUB for `x86_64-pc-elf` requires the `gcc` and GNU `binutils` toolchain for that target, which is available in [my tap](https://github.com/hawkw/homebrew-x86_64-pc-elf).
