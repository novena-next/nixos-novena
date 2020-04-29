{ stdenv
, fetchFromGitHub
, linuxHeaders
}:
stdenv.mkDerivation rec {
  pname = "novena-eeprom";
  version = "b3de8b9";

  /*
  src = fetchFromGitHub {
    owner = "xobs";
    repo = pname;
    rev = version;
    sha256 = "00pd71mg0g20v0820ggp3ghf9nyj5s4wavaz9mkmrmsr91hcnf7i";
  };
  */
  src = /etc/nixos/novena-eeprom;

  doCheck = false;
  buildInputs = [ linuxHeaders ];
  makeFlags = [ "PREFIX=$(out)" ];

  meta = {
    description = "Manipulate the contents of Novena's personality EEPROM ";
    longDescription = ''
      Novena boards contain a device-dependent descriptive EEPROM that defines various parameters such as serial number, MAC address, and featureset. This program allows you to view and manipulate this EEPROM list.
    '';
    homepage = https://github.com/xobs/novena-eeprom/;
    license = stdenv.lib.licenses.bsd3;
    maintainers = [ stdenv.lib.maintainers.srk ];
    platforms = stdenv.lib.platforms.linux;
  };
}
