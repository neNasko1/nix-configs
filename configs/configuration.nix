{ config, pkgs, inputs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
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

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    portalPackage = inputs.hyprland.packages."${pkgs.system}".xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  programs.zsh.enable = true;

  systemd.user.services.start-hyprland = {
    description = "Start hyprland after logging in tty";
    serviceConfig.PassEnvironment = "DISPLAY";
    script = ''
      hyprland
    '';
    wantedBy = [ "multi-user.target" ];
  };

  users.users.atanasd = {
    isNormalUser = true;
    description = "Atanas Dimitrov";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    gcc
    cmake
    telegram-desktop
    wpa_supplicant
    python3
    just
    chromium
    unzip
  ];

  virtualisation.docker.enable = true;
}
