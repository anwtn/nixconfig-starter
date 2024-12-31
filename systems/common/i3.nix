{
  config,
  pkgs,
  callPackage,
  ...
}: {
  environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw

  services = {
    xserver = {
      enable = true;

      desktopManager = {
        xterm.enable = false;
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu # application launcher most people use
          i3status # gives you the default i3 status bar
          i3lock # default i3 screen locker
          i3blocks # if you are planning on using i3blocks over i3status
        ];
      };
    };

    # Updated displayManager options
    displayManager = {
      defaultSession = "none+i3"; # Renamed from services.xserver.displayManager.defaultSession
      autoLogin = {
        enable = true; # Renamed from services.xserver.displayManager.autoLogin.enable
        user = "aaronnewton"; # Renamed from services.xserver.displayManager.autoLogin.user
      };
      # job.preStart = "sleep 2"; # Hack to ensure X is ready for autoLogin
    };
  };

  # Keyring
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  # File manager and related services
  environment.systemPackages = with pkgs; [xfce.thunar];
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
    # # Wayland support.
    # sway
    # wayland
    # xwayland
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Network and power management
  programs.nm-applet.enable = true;
  services.upower.enable = true;
}
