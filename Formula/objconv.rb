class Objconv < Formula
  desc "Object file converter and disassembler"
  homepage "http://www.agner.org/optimize/#objconv"
  url "http://www.agner.org/optimize/objconv.zip"
  version "2.44"
  sha256 "fbb50d84279ed6f38304cd199f56a2ef46cebf136c2611078b97ec2b3f3ce636"
  def install
    system "unzip", "source.zip",
                    "-dsrc"
    # objconv doesn't have a Makefile, so we have to call
    # the C++ compiler ourselves
    system ENV.cxx, "-o", "objconv",
                    "-O2",
                    *Dir["src/*.cpp"],
                    "--prefix=#{prefix}"
    bin.install "objconv"
  end

  test do
    system "#{bin}/objconv", "-h"
    # TODO: write better tests
  end
end
