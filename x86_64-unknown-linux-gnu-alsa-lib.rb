class X8664UnknownLinuxGnuAlsaLib < Formula
  desc "alsa-lib for x86_64-unknown-linux-gnu cross development"
  homepage "https://www.alsa-project.org/"
  url "https://www.alsa-project.org/files/pub/lib/alsa-lib-1.2.10.tar.bz2"
  sha256 "c86a45a846331b1b0aa6e6be100be2a7aef92efd405cf6bac7eef8174baa920e"
  license "GPL-2.1-or-later"

  livecheck do
    url "https://www.alsa-project.org/files/pub/lib/"
    regex(/href=.*?alsa-lib[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  on_linux do
    keg_only "it conflicts with `alsa-lib`"
  end

  depends_on "messense/macos-cross-toolchains/x86_64-unknown-linux-gnu" => :build

  def install
    x86_64_gnu_path = Formula["x86_64-unknown-linux-gnu"].opt_bin
    host = "x86_64-unknown-linux-gnu"

    # set cross compile env variables
    ENV.deparallelize    
    ENV["PATH"] = "/opt/homebrew/bin:#{ENV["PATH"]}"
    ENV["CC"] = "#{x86_64_gnu_path}/x86_64-unknown-linux-gnu-gcc"    
    ENV["CXX"] = "#{x86_64_gnu_path}/x86_64-unknown-linux-gnu-g++"
    
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--libdir=#{lib/host}",
                          "--infodir=#{info/host}",
                          "--host=#{host}"
    system "make", "install"
  end
end
