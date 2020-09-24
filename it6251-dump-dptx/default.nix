{ stdenv
, fetchFromGitHub
, linuxHeaders
}:
stdenv.mkDerivation rec {
  pname = "it6251-dump-dptx";
  version = "70b07ef";

  src = fetchFromGitHub {
    owner = "xobs";
    repo = pname;
    rev = version;
    sha256 = "175q4lc6c7yqqksy68v70h8rskikhf9l2phbw8v2l5vcsk3q8w8k";
  };

  buildInputs = [ linuxHeaders ];
  installPhase = ''
    mkdir $out
    cp it6251-dump-dptx $out/
  '';

  meta = {
    description = "Reads the EDID out of the LCD panel connected to the IT6251";
    homepage = "https://github.com/xobs/it6251-dump-dptx/";
    license = stdenv.lib.licenses.bsd3;
    maintainers = [ stdenv.lib.maintainers.sorki ];
    platforms = stdenv.lib.platforms.linux;
  };
}
