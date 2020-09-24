# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="770ecb1d3134a7b0e4469eb790836bd837c9f675";
  hash="0q8kdh5ww9cm28pf9y47q2p4g4q4ipf34zr087vld7zdykjkxi9a";
in
import (
  "${fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }}/nixos"
)
