{ stdenv
, fetchFromGitHub
, pkgconfig
, libusb1
}:
stdenv.mkDerivation rec {
  pname = "novena-usb-hub";
  version = "2b8d8c8";

  src = fetchFromGitHub {
    owner = "novena-next";
    repo = pname;
    rev = version;
    sha256 = "0zf85a3zqxafyh4z0l4jmvkxq7ww2yic63plhw2xmx414y75vfgq";
  };

  doCheck = false;
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libusb1 ];
  makeFlags = [ "PREFIX=$(out)" ];

  meta = {
    description = "USB power and overcurrent control for internal and external USB ports on Novena.";
    homepage = "https://github.com/novena-next/novena-usb-hub/";
    license = stdenv.lib.licenses.bsd3;
    maintainers = [ stdenv.lib.maintainers.sorki ];
    platforms = stdenv.lib.platforms.linux;
  };
}
