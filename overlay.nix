final: super:

let
  inherit (final) callPackage kernelPatches linuxPackagesFor;
in
  {
    novena-eeprom = callPackage ./novena-eeprom {};
    novena-usb-hub = callPackage ./novena-usb-hub {};

    linux_nvn = callPackage ./kernel {
      # with final.lib.kernel?
      structuredExtraConfig = with import <nixpkgs/lib/kernel.nix> { inherit (super) lib; version = super.linux_nvn.version; }; {
        DRM_ETNAVIV = module;
        DRM_ETNAVIV_THERMAL = yes;
        DRM_ITE_IT6251 = module;
        USB_NET_AX8817X = module;
        SND_SOC_IMX_ES8328 = module;

        REGULATOR_PFUZE100 = module;
        # NET_ETHERNET m
        USB_SERIAL_PL2303 = module;
        USB_SERIAL_CH341 = module;

        # ZZZ
        DRM_NOUVEAU = no;
        DRM_RADEON = no;
        DRM_EXYNOS = no;
        E1000E = no;
        IGB = no;
      };
      kernelPatches = [ ];
    };
    linuxPackages_nvn = linuxPackagesFor final.linux_nvn;

  }
