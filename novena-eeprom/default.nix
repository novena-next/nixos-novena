{ stdenv
, fetchFromGitHub
, linuxHeaders
}:
stdenv.mkDerivation rec {
  pname = "novena-eeprom";
  version = "19b320b";

  src = fetchFromGitHub {
    owner = "novena-next";
    repo = pname;
    rev = version;
    sha256 = "0ldmpbvcq5qs3km1lcggd6k36x6n4qlr1knwmq69d7inp028iy7d";
  };

  doCheck = false;
  buildInputs = [ linuxHeaders ];
  makeFlags = [ "PREFIX=$(out)" ];

  meta = {
    description = "Manipulate the contents of Novena's personality EEPROM ";
    longDescription = ''
      Novena boards contain a device-dependent descriptive EEPROM that defines various parameters such as serial number, MAC address, and featureset. This program allows you to view and manipulate this EEPROM list.
    '';
    homepage = "https://github.com/novena-next/novena-eeprom/";
    license = stdenv.lib.licenses.bsd3;
    maintainers = [ stdenv.lib.maintainers.sorki ];
    platforms = stdenv.lib.platforms.linux;
  };
}
