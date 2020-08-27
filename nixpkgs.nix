# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="ecef3f9794bdb59f56193c9084e32bc7367d5e70";
  hash="03gqhmzky4130avlmj2zzf4zvfxmia67g9y5y91haah654c4v082";
in
import (
  "${fetchTarball {
    # currently forked due to two patches
    # https://github.com/NixOS/nixpkgs/pull/96459
    # https://github.com/NixOS/nixpkgs/pull/96460
    url = "https://github.com/NixOS/sorki/archive/${rev}.tar.gz";
    sha256 = hash;
  }}/nixos"
)
