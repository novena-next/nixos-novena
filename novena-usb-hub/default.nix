{ stdenv
, fetchFromGitHub
, pkgconfig
, libusb1
}:
stdenv.mkDerivation rec {
  pname = "novena-usb-hub";
  version = "4b1123a";

  src = fetchFromGitHub {
    owner = "novena-next";
    repo = pname;
    rev = version;
    sha256 = "1gry9pmap2xfx2dh6a0alvs5aaspahifbvkifdxw4pawsakqgnjs";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ pkgconfig libusb1 ];
  makeFlags = [
    "PREFIX=$(out)"
    "PKGCONFIG=${pkgconfig}/bin/${pkgconfig.targetPrefix}pkg-config"
  ];

  meta = {
    description = "USB power and overcurrent control for internal and external USB ports on Novena.";
    homepage = "https://github.com/novena-next/novena-usb-hub/";
    license = stdenv.lib.licenses.bsd3;
    maintainers = [ stdenv.lib.maintainers.sorki ];
    platforms = stdenv.lib.platforms.linux;
  };
}
