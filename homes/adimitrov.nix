{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/neovim.nix
    ./modules/tmux.nix
    ./modules/lazygit.nix
    ./modules/htop.nix
    ./modules/zsh.nix
  ];

  home.username = "adimitrov";
  home.homeDirectory = "/home/adimitrov";

  home.packages = with pkgs; [
    fzf
    ripgrep
    tree
  ];

  targets.genericLinux.enable = true;

  home.file.".tmux.conf".text = config.xdg.configFile."tmux/tmux.conf".text;

  programs.tmux.secureSocket = false;

  programs.zsh.envExtra = ''
    export PATH="$HOME/.local/state/nix/profiles/home-manager/home-path/bin:$PATH"
    export NIX_PROFILES="/nix/var/nix/profiles/default $HOME/.local/state/nix/profiles/home-manager $HOME/.nix-profile"
  '';
  programs.zsh.profileExtra = ''
    export PATH="$HOME/.local/state/nix/profiles/home-manager/home-path/bin:$PATH"
    export NIX_PROFILES="/nix/var/nix/profiles/default $HOME/.local/state/nix/profiles/home-manager $HOME/.nix-profile"
  '';

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
