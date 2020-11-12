{ config, lib, pkgs, ... }:

# lightdm + i3 example

{

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  # if you want to try sway
  programs.sway = {
   enable = false;
   extraPackages = with pkgs; [ swaylock swayidle xwayland rxvt_unicode dmenu ];
  };

  environment.systemPackages = with pkgs; [
    rxvt_unicode
    mpv
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = lib.mkForce [ "modesetting" ];
    serverFlagsSection = ''
      Option "AutoAddGPU" "false"
    '';
    deviceSection = ''
      Option "kmsdev" "/dev/dri/card1"
      Option "AccelMethod" "none"
    '';

    # so it's in etc
    exportConfiguration = true;

    displayManager.lightdm.enable = true;

    desktopManager.xterm.enable = true;
    windowManager.i3 = {
      enable = true;
    };
  };

  # use fc-list to list fonts
  fonts.fonts = with pkgs; [
      anonymousPro
      #corefonts
      dejavu_fonts
      freefont_ttf
      hasklig
      inconsolata
      liberation_ttf
      #powerline-fonts
      source-code-pro
      #symbola
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family
      #nerdfonts
      hack-font
    ];

}
