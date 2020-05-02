{ stdenv
, fetchFromGitHub
, pkgconfig
, libusb1
}:
stdenv.mkDerivation rec {
  pname = "novena-usb-hub";
  version = "b3de8b9";

  /*
  src = fetchFromGitHub {
    owner = "xobs";
    repo = pname;
    rev = version;
    sha256 = "00pd71mg0g20v0820ggp3ghf9nyj5s4wavaz9mkmrmsr91hcnf7i";
  };
  */
  src = /etc/nixos/novena-usb-hub;

  doCheck = false;
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libusb1 ];
  makeFlags = [ "DESTDIR=$(out)" ];

  meta = {
    description = "USB power and overcurrent control for internal and external USB ports on Novena.";
    homepage = https://github.com/xobs/novena-usb-hub/;
    license = stdenv.lib.licenses.bsd3;
    maintainers = [ stdenv.lib.maintainers.sorki ];
    platforms = stdenv.lib.platforms.linux;
  };
}
