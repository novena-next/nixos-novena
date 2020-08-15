{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (import ./overlay.nix)
    # (self: super: { mpv = super.mpv.override { sambaSupport = false; }; })
  ];

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image.nix>
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible = {
    enable = true;
    configurationLimit = 30;
  };

  boot.kernelPackages = pkgs.linuxPackages_nvn;
  system.stateVersion = "20.09";

  environment.systemPackages = with pkgs; [
    wget screen vim

    novena-eeprom
    usbutils
    # more cross issues
    # https://github.com/NixOS/nixpkgs/pull/86645
    #libgpiod
    #powertop
    #lm_sensors
    #novena-usb-hub
  ];

  # minification
  security.polkit.enable = false;
  services.udisks2.enable = lib.mkForce false;

  sdImage =
  let
    extlinux-conf-builder =
      import <nixpkgs/nixos/modules/system/boot/loader/generic-extlinux-compatible/extlinux-conf-builder.nix> {
        pkgs = pkgs.buildPackages;
      };
  in
  {
    # causes bzip2 compression of image already compressed by zstd
    compressImage = false;

    imageBaseName = "nixos-novena-sd-image";

    populateFirmwareCommands = ''
        cp ${pkgs.pkgsCross.armv7l-hf-multiplatform.ubootNovena}/u-boot.bin u-boot.bin
      '';
    populateRootCommands = ''
        mkdir -p ./files/boot
        ${extlinux-conf-builder} -t 3 -c ${config.system.build.toplevel} -d ./files/boot
      '';
  };

}
