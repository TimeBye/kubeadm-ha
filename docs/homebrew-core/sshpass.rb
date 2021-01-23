require 'formula'

class Sshpass < Formula
  url 'https://sourceforge.net/projects/sshpass/files/sshpass/1.07/sshpass-1.07.tar.gz'
  homepage 'https://sourceforge.net/projects/sshpass'
  sha256 '986973c8dd5d75ff0febde6c05c76c6d2b5c4269ec233e5518f14f0fd4e4aaef'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end