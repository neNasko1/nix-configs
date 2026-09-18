{ config, pkgs, inputs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
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
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.blueman.enable = true;
  # hardware.bluetooth.settings = { General = { ControllerMode = "bredr"; }; };
  services.printing.enable = true;
  services.pulseaudio.enable = false;
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
  programs.steam.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    gnome-characters
    gnome-music
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
      libGLU
      openssl
      zlib
      stdenv.cc.cc
      libffi
      libtinfo
      libxml2
      xorg.libX11
      xorg.libXext
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXi
      xorg.libXxf86vm
      openal
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
    tmux
  ];

  users.users.atanasd = {
    isNormalUser = true;
    description = "Atanas Dimitrov";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      wpa_supplicant
      mosh
      just
      tcl
      zathura
      typst
      lean4
      sbcl
      wireshark
      gparted
      wine
      telegram-desktop
      chromium
      firefox
      spotify
      unoconv
      qpdf
      pdftk
      ghostscript
      bear
      jq
      texlive.combined.scheme-full
      pandoc
      ghostty
      hyperfine
      (aspellWithDicts
        (dicts: with dicts; [ en en-computers en-science ]))
      llvmPackages.llvm
      llvmPackages.llvm.dev
      llvmPackages.libllvm
      llvmPackages.clang
      llvmPackages.lld
      llvmPackages.clang-tools
      ninja
      openssl
      openssl.dev
      pkg-config
      protobuf
      gthumb
      openconnect
      ffmpeg
      yt-dlp
      poppler-utils
      wine
      steam
      lazygit
    ];
  };
}
