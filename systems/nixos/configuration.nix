# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  ...
}: let nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common/i3.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # AJN 20230731 - disable intel graphics integrated GPU. This is a workaround.
  # https://nixos.wiki/wiki/Nvidia#Fix_black_screen_on_a_system_with_an_integrated_GPU
  # boot.kernelParams = [ "module_blacklist=i915" ];

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-27da2bce-9f3e-4fdc-b280-77023f2c7cb6".device = "/dev/disk/by-uuid/27da2bce-9f3e-4fdc-b280-77023f2c7cb6";
  boot.initrd.luks.devices."luks-27da2bce-9f3e-4fdc-b280-77023f2c7cb6".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable ClamAv virus scanning
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver = {
  #   layout = "au";
  #   xkbVariant = "";
  # };

  #### NVIDIA specific configuration

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  hardware.enableAllFirmware = true;

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.prime = {
    # sync.enable = true;
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  #### END: NVIDIA specific configuration


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aaronnewton = {
    isNormalUser = true;
    description = "Aaron Newton";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = "/etc/profiles/per-user/aaronnewton/bin/zsh";
  };

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "aaronnewton";

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    # Ref https://jointhefreeworld.org/blog/articles/gnu-linux/openvpn3-on-nixos-with-web-based-saml.html
    openvpn3
    # Avahi networking to allow for domains like host.local
    nssmdns
    # Terminal file manager
    yazi
    # Needed for DBUS?
    dconf
  ];

  # Enable mdns for resolving .local domains
  networking.hosts = {
    "127.0.0.1" = [ 
      "host.local"
      "wwl.local"
      "ppc.local"
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Ref https://jointhefreeworld.org/blog/articles/gnu-linux/openvpn3-on-nixos-with-web-based-saml.html
  programs.openvpn3.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  #services.xserver.videoDrivers = ["nvidia"];
  #hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.powerManagement.enable = false;
  #hardware.nvidia.prime = {
  # sync.enable = true;
  #  offload.enable = true;
  #  intelBusId = "PCI:0:2:0";
  #  nvidiaBusId = "PCI:1:0:0";
  #};

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # Fixes infuriating blueman issue.
  services.dbus.enable = true;
  programs.dconf.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
