{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Europe/Kyiv";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  users.users.kyd0 = {
    isNormalUser = true;
    description = "Denys";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      kitty
      rofi
      polybar
      ranger
      fastfetch
      mpd
      mpv
      feh
      telegram-desktop
      libreoffice
      obs-studio
      shotcut
      scrot
      maim
      slop
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [
      pkgs.intel-media-driver
      pkgs.vulkan-tools
      pkgs.libvdpau-va-gl
    ];
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  services.xserver = {
    enable = true;

    libinput = {
      enable = true;

      mouse = {
        accelProfile = "flat";
        accelSpeed = "0.0";
      };
    };

    windowManager.bspwm.enable = true;

    displayManager = {
      lightdm = {
        enable = true;
        greeters.gtk.enable = true;
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      bs = "sudo nvim /home/kyd0/.config/bspwm/bspwmrc";
      sx = "sudo nvim /home/kyd0/.config/sxhkd/sxhkdrc";
      nx = "sudo nvim /etc/nixos/configuration.nix";
      rb = "sudo nixos-rebuild switch";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    htop
    wget
    curl
    bibata-cursors
    unzip
    nodejs
    python3
    gcc
    qbittorrent
    vim
    vscode
    jdk21
    xclip
    xorg.xrandr
    xorg.xsetroot
    live-server
  ];

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "16";
  };

  fonts.packages = with pkgs; [
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.font-awesome
  ];

  services.tlp.enable = true;

  nix.settings.experimental-features = [ "nix-command"  "flakes" ];

  system.stateVersion = "25.11";

}

