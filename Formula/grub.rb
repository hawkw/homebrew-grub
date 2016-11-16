# right now, all that will work is
# "brew install grub --with-x86_64-pc-elf --HEAD"
class Grub < Formula
  desc "GNU GRUB bootloader"
  homepage "https://www.gnu.org/software/grub/"
  url "ftp://ftp.gnu.org/gnu/grub//grub-2.00.tar.xz"
  sha256 ""
  head "git://git.savannah.gnu.org/grub.git", :using => :git
  version "2.00"

  # targets ##################################################################
  option "with-x86_64-pc-elf", "Build for the x86_64-pc-elf target"

  # other options ############################################################
  option "with-gfxterm", "build GRUB's graphical terminal (gfxterm)"
  option "with-grub-emu", "build optional grub-emu features"
  option "without-test", "Skip compile-time make checks"

  # dependencies #############################################################
  depends_on "xorriso"

  # build dependencies #######################################################
  depends_on "hawkw/grub/objconv" => :build
  depends_on "binutils" => :build
  depends_on :xcode => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "python" => :build

  # option-specific dependencies #############################################
  depends_on "freetype" if build.with? "gfxterm"
  depends_on "qemu" => :build if build.with? "test"

  if build.with? "grub-emu"
      depends_on "sdl" => :recommended
      depends_on "libusb" => :optional
  end

  # target-specific dependenices #############################################
  if build.with? "x86_64-pc-elf"
    depends_on "x86_64-pc-elf-binutils" => :build
    depends_on "x86_64-pc-elf-gcc" => :build

    fails_with :clang => "3.1" do
      cause "According to the official README, clang 3.2 or greater is required"
    end
  end

  def install
    target = "x86_64-pc-elf" if build.with? "x86_64-pc-elf"

    args = %W[
      --disable-werror
      --target=#{target}
      --prefix=#{prefix}
      TARGET_CC=#{target}-gcc
      TARGET_OBJCOPY=#{target}-objcopy
      TARGET_STRIP=#{target}-strip
      TARGET_NM=#{target}-nm
      TARGET_RANLIB=#{target}-ranlib
    ]

    args << "--host=#{target}" if build.with? "grub-emu"
    # args << ""

    system "sh", "autogen.sh"

    mkdir "build" do
        system "../configure", *args
        system "make", "check" if build.with? "test"
        system "make"
        system "make", "install"
    end

  end
  #
  # test do
  # end
end
