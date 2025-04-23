{ config, pkgs, inputs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "unstable";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.settings = {
    IPv6 = {
      Enabled = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  # hardware.bluetooth.settings = { General = { ControllerMode = "bredr"; }; };
  services.printing.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  time.timeZone = "Europe/Sofia";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "bg_BG.UTF-8";
    LC_IDENTIFICATION = "bg_BG.UTF-8";
    LC_MEASUREMENT = "bg_BG.UTF-8";
    LC_MONETARY = "bg_BG.UTF-8";
    LC_NAME = "bg_BG.UTF-8";
    LC_NUMERIC = "bg_BG.UTF-8";
    LC_PAPER = "bg_BG.UTF-8";
    LC_TELEPHONE = "bg_BG.UTF-8";
    LC_TIME = "bg_BG.UTF-8";
  };

  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  #   portalPackage = inputs.hyprland.packages."${pkgs.system}".xdg-desktop-portal-hyprland;
  #   xwayland.enable = true;
  # };

  # systemd.user.services.start-hyprland = {
  #   description = "Start hyprland after logging in tty";
  #   serviceConfig.PassEnvironment = "DISPLAY";
  #   script = ''
  #     hyprland
  #   '';
  #   wantedBy = [ "multi-user.target" ];
  # };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.xterm.enable = false;
  };

  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    gnome-characters
    gnome-music
    gnome-photos
    gnome-tour
    gnome-terminal
    gnome-console
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
    xterm
  ]);

  programs.zsh.enable = true;
  virtualisation.docker.enable = true;
  programs.wireshark.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glfw
      libGL
      openssl
      zlib
      stdenv.cc.cc
    ];
  };

  environment.systemPackages = with pkgs; [
    gcc14
    cmake
    gnumake
    zip
    unzip
    bash
    cargo
    rustc
  ];

  users.users.atanasd = {
    isNormalUser = true;
    description = "Atanas Dimitrov";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      wpa_supplicant
      just
      tcl
      zathura
      typst
      sbcl
      wireshark
      gparted
      wine
      ventoy
      telegram-desktop
      chromium
      firefox
      spotify
      unityhub
      unoconv
      qpdf
      pdftk
      ghostscript
      bear
      jq
      texlive.combined.scheme-full
    ];
  };
}
