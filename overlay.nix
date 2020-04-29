final: super:

let
  inherit (final) callPackage kernelPatches linuxPackagesFor;
in
  {
    novena-eeprom = callPackage ./novena-eeprom {};
    novena-usb-hub = callPackage ./novena-usb-hub {};

    linux_nvn = callPackage ./kernel {
      kernelPatches = [];
    };
    linuxPackages_nvn = linuxPackagesFor final.linux_nvn;

  }
