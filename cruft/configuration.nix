{ config, pkgs, lib, ... }:

{
  imports = [
    ./desktop.nix
    ./hardware-configuration.nix
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible = {
    enable = true;
    configurationLimit = 30;
  };

  boot.kernelPackages = pkgs.linuxPackages_nvn;

  boot.kernelParams = [ "boot.shell_on_fail" ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    platform = { # imx6q
      name = "novena";
      kernelArch = "arm";
      kernelAutoModules = true;
      kernelBaseConfig = "multi_v7_defconfig";
      kernelPreferBuiltin = true;
      kernelTarget = "zImage";
      kernelDTB = true;
      gcc = { arch = "armv7-a"; float = "hard"; fpu = "vfpv3-d16"; };
    };
  };

  nixpkgs.overlays = [
      (import ./nixos-novena/overlay.nix)
      (self: super: { mpv = super.mpv.override { sambaSupport = false; }; })
    ];

  # MINIfied
  #environment.noXlibs = true;
  i18n.supportedLocales = [ (config.i18n.defaultLocale + "/UTF-8") ];

  documentation.enable = true;
  documentation.nixos.enable = true;

  #services.xserver.enable = false;
  services.xserver.desktopManager.xterm.enable = lib.mkForce false;

  services.udisks2.enable = lib.mkForce false;

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    wget screen
    (import ./vim.nix {})
    libgpiod
    powertop
    lm_sensors
    novena-eeprom
    novena-usb-hub
    usbutils

    gdb
    socat

    mupdf
    mosh
    eternal-terminal
  ];

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  system.stateVersion = "20.03";

}
