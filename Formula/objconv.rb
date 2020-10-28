class Objconv < Formula
  desc "Object file converter and disassembler"
  homepage "https://github.com/gitGNU/objconv"
  url "https://github.com/gitGNU/objconv/archive/v2.50.tar.gz"
  version "2.50"
  sha256 "b14fcdcee14f9db9e9c89f53482df8d84a2979dbbf6b4cdc556972b2653a1b86"
  def install
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
