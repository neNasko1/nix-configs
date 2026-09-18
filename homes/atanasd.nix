{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/git.nix
    ./modules/neovim.nix
    ./modules/tmux.nix
    ./modules/zsh.nix
    ./modules/dconf.nix
    ./modules/newsboat.nix
    ./modules/lazygit.nix
    ./modules/htop.nix
  ];

  home.username = "atanasd";
  home.homeDirectory = "/home/atanasd";

  home.file.".config/harper-ls/user.dict".text = lib.concatStringsSep "\n" [
    "Atanas"
    "Dimitrov"
  ];

  programs.nixvim = {
    plugins = {
      lean.enable = true;
      web-devicons.enable = true;
      guess-indent.enable = true;

      lsp.servers = {
        pyright = {
          enable = true;
          settings = {
            pyright.disableOrganizeImports = true;
            python.analysis.ignore = [ "*" ];
          };
        };
        nil_ls = {
          enable = true;
          settings.nix.flake.autoArchive = true;
        };
        ocamllsp.enable = true;
        harper_ls = {
          enable = true;
          settings = {
            "harper-ls" = {
              userDictPath = "${config.home.homeDirectory}/.config/harper-ls/user.dict";
              workspaceDictPath = "";
              fileDictPath = "";
              linters = {
                SpellCheck = true;
                SpelledNumbers = false;
                AnA = true;
                SentenceCapitalization = true;
                UnclosedQuotes = true;
                WrongQuotes = false;
                LongSentences = true;
                RepeatedWords = true;
                Spaces = true;
                Matcher = true;
                CorrectNumberSuffix = true;
              };
              codeActions = {
                ForceStable = false;
              };
              markdown = {
                IgnoreLinkTitle = false;
              };
              diagnosticSeverity = "hint";
              isolateEnglish = false;
              dialect = "American";
              maxFileLength = 120000;
            };
          };
        };
      };
    };
  };

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
