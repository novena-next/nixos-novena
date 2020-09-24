# nixos-novena

Overlay and sample `configuration.nix` which can be used to build an installer
image for Novena laptop.


## Building the installer

To build either natively or using cross compilation toolchain, use

```
./build.sh
```

## Flashing the installer

```
dd if=result-img/sd-image/nixos-novena-sd-image-20.09pre-git-armv7l-linux.img \
   of=/dev/mmcblkX \
   bs=1M
```

## Installation

Proceed according to standard NixOS installation instructions. Don't forget
to clone this repository and import the overlay.

In `configuration.nix`, select the custom kernel with
```
boot.kernelPackages = pkgs.linuxPackages_nvn
```

If using cross-compiled installer the initial installation might take several days
as Nix cannot reuse cross-compiled packages from installers `/nix/store` and
has to build whole world from scratch including bootstrap packages. Make sure to
supply additional cooling or limit the compilation to 3 cores with `--option cores 3`.
