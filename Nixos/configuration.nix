# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ config, pkgs, libs, ...}: 

let
 tokyo-night-sddm = pkgs.callPackage ./pkgs-mine/tokyo-night-sddm.nix {  };
 catppuccin-sddm = pkgs.callPackage ./pkgs-mine/catppuccin-sddm.nix { };
 font-helveticanow = pkgs.callPackage ./pkgs-mine/font-helveticanow.nix { };
in
  

 {

   programs.hyprland.enable = true;
  
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
                "openssl-1.1.1u"
              ];
  #nixpkgs.config.allowBroken = true

nix.extraOptions = ''
    experimental-features = nix-command
    '';


  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ]; 

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
  
      font-awesome
      font-helveticanow    
      (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "FiraCode" "JetBrainsMono" "Lekton" "Meslo"  ]; })
      
          ];
    
 
  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.forceInstall = false; # RISKY!

  boot.loader.grub.enable                = true;
  boot.loader.grub.copyKernels           = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport            = true;
  boot.loader.grub.configurationLimit    = 5;
  #boot.loader.grub.fsIdentifier          = "label";
  #boot.loader.grub.splashImage           = ./backgrounds/grub-nixos-3.png;
  #boot.loader.grub.splashMode            = "stretch";

  boot.loader.grub.devices               = [ "nodev" ];
  boot.loader.grub.extraEntries = ''
    menuentry "Reboot" {
      reboot
    }
    menuentry "Poweroff" {
      halt
    }
 '';
 networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
 time.timeZone = "America/Toronto";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
services.xserver = {
        enable = true;
        xkbVariant = "";
      };

#Display manager sddm
      
services.xserver.displayManager.sddm.enable = true;
#services.xserver.displayManager.sddm.theme = "tokyo-night-sddm";
services.xserver.displayManager.sddm.theme = "catppuccin-frappe";    



services.xserver.displayManager = {        
           autoLogin.enable = true;
           autoLogin.user = "cris"; 
       };

services = {
       udisks2.enable = true;
       gvfs.enable = true;
       devmon.enable = true;
       thermald.enable = true;
       };

  # Configure keymap in X11
   services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Bluethooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  #services.gnome3.gnome-keyring.enable = true;

  
   # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

   

  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;



# Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.cris = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "input" "rfkill" "disk" "kvm" "audio" "video" "camera"]; 
     packages = with pkgs; [
         ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget


  
  environment.systemPackages = with pkgs; [
    accountsservice
    alacritty
    brightnessctl
    
    cava
    cinnamon.nemo-fileroller
    cinnamon.nemo-with-extensions
    cinnamon.nemo-python
    #nemo-compare
    cliphist
    clipmenu
    cmake
    dmenu
    dmenu-wayland
    egl-wayland
    fontconfig
    fontpreview
    freetype
    gcc
    git
    gnome.gnome-keyring
    gnome.dconf-editor
    gnumake
    gtk3
    hyprland
    hyprland-protocols
    ifwifi
    jq
    killall
    kitty
    libdecor
    polkit-kde-agent
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5.qtgraphicaleffects
    lxappearance
    mako
    meld
    meson
    mpv
    nano # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neofetch
    networkmanager
    networkmanagerapplet
    qt5.qtwayland
    qt6.qtwayland
    ripgrep
    rofi-wayland
    silver-searcher
    slurp
    sublime4
    swaybg
    swaylock-effects
    swww
    thermald
    tilix
    tty-clock 
    wayland-utils
    wl-clipboard
    wlr-randr
    wget
    wofi
    xmlto
    wlogout
    wlroots
    xdg-desktop-portal-hyprland
    xdg-utils

    tokyo-night-sddm
    catppuccin-sddm

    ];

       
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.gnupg.agent.enable = true;
  
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  security = {
    sudo.wheelNeedsPassword = false;
    polkit.enable = true;
    rtkit.enable = true;
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  }; 
  systemd = {
    user.services.polkit-kde-authentication-agent-1= {
      description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
   
   extraConfig = ''
     DefaultTimeoutStopSec=6s
   '';
  }; 
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
    pkgs.xdg-desktop-portal-hyprland
       ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  #system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05"; 
 }
