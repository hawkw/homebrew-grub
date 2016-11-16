# right now, all that will work is
# "brew install grub --with-x86_64-pc-elf --HEAD"
class Grub < Formula
  desc "GNU GRUB bootloader"
  homepage "https://www.gnu.org/software/grub/"
  url "git://git.savannah.gnu.org/grub.git"
  sha256 ""
  head "git://git.savannah.gnu.org/grub.git", :using => :git
  # head "git://git.savannah.gnu.org/grub.git", :using => :git
  version "2.02"
  # depends_on "cmake" => :build
  # depends_on :x11 # if your formula requires any X11/XQuartz components

  # targets ##################################################################
  option "with-x86_64-pc-elf", "Build for the x86_64-pc-elf target"

  # other options ############################################################
  option "with-gfxterm", "build GRUB's graphical terminal (gfxterm)"
  option "with-grub-emu", "build optional grub-emu features"

  # x86_64 = "hawkw/x86_64-pc-elf/x86_64-pc-elf"
  depends_on "hawkw/grub/objconv" => :build
  depends_on "binutils" => :build
  depends_on :xcode => :build

  depends_on "xorriso"

  # option-specific dependencies #############################################
  depends_on "freetype" if build.with? "gfxterm"

  # target-specific dependenices #############################################
  if build.with? "x86_64-pc-elf"
    depends_on "x86_64-pc-elf-binutils" => :build
    depends_on "x86_64-pc-elf-gcc" => :build

    fails_with :clang => "3.1" do
      cause "According to the official README, clang 3.2 or greater is required"
   end
  end
  # depends_on "gcc" => :build
  # target_cc = if build.with?("x86_64-pc-elf") then Formula["x86_64-pc-elf-gcc"] else Nil end

  head do

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "python" => :build

  end

  def install
    target = "x86_64-pc-elf" if build.with? "x86_64-pc-elf"

    system "sh", "autogen.sh" if build.head?
    # target_cc = Formula["#{target}-gcc"]
    # target_binutils = Formula["#{target}-binutils"]
    # target_binutils_path = "#{target_binutils.bin}#{target}"
    # build_gcc = Formula["gcc"]

    system "./configure", "--disable-werror",
                        #   "BUILD_CC=#{gcc}"
                        #   "TARGET_CC=#{target_cc.bin}/#{target_cc}",
                        #   "TARGET_OBJCOPY=#{target_binutils_path}-objcopy",
                        #   "TARGET_STRIP=#{target_binutils_path}-strip",
                          "TARGET_CC=#{target}-gcc",
                          "TARGET_OBJCOPY=#{target}-objcopy",
                          "TARGET_STRIP=#{target}-strip",
                          "TARGET_NM=#{target}-nm",
                          "TARGET_RANLIB=#{target}-ranlib",
                          "--target=#{target}",
                          "--prefix=#{prefix}"
                        #   "CC=gcc"
    system "make"
    system "make", "install"
  end
  #
  # test do
  # end
end
