{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/git.nix
    ./modules/neovim.nix
    ./modules/zsh.nix
    ./modules/dconf.nix
    ./modules/newsboat.nix
  ];

  home.username = "atanasd";
  home.homeDirectory = "/home/atanasd";
  home.packages = with pkgs; [
    dconf

    alacritty
    fish

    pamixer
    pulseaudio
    pavucontrol
    blueman

    arandr
    feh
    swww

    htop
    fortune
    wofi
    wl-clipboard
    firefox
    font-awesome
    fzf
    tree
    git
    ripgrep

    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono

    (buildFHSEnv {
      name = "pixi";
      runScript = "pixi";
      targetPkgs = pkgs: with pkgs; [ pixi ];
    })
    nil
    ruff
    pyright
    ccls
    ocaml
    ocamlPackages.ocaml
    ocamlPackages.dune_3
    ocamlPackages.findlib
    ocamlPackages.utop
    ocamlPackages.odoc
    ocamlPackages.ocaml-lsp
    ocamlformat
    vale
    vale-ls
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.11";
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
