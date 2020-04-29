{ config, lib, pkgs, ... }:

{

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  programs.sway = {
   enable = true;
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
    # in etc
    exportConfiguration = true;

    #displayManager.startx.enable = true;
    displayManager.lightdm.enable = true;
    #displayManager.defaultSession = "sway";

    #desktopManager.default      = "none";   # the plain xmonad experience
    desktopManager.xterm.enable = true;
    windowManager.i3 = {
      enable = true;
    };

    #windowManager.default       = "none"; # sets it as default
    #windowManager.default       = "xmonad"; # sets it as default
    #windowManager.xmonad = {
    #  enable = true;     # installs xmonad and makes it available
    #  enableContribAndExtras = true; # makes xmonad-contrib and xmonad-extras available
    #};
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
