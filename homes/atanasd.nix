{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/git.nix
    ./modules/neovim.nix
    ./modules/zsh.nix
  ];

  home.username = "atanasd";
  home.homeDirectory = "/home/atanasd";
  home.packages = with pkgs; [
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

    (nerdfonts.override { 
      fonts = [ 
        "FiraCode"
        "DroidSansMono" 
        "JetBrainsMono"
      ]; 
    })

    (buildFHSUserEnv {
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
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.05";
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    }; 
  };
}
