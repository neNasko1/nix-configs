{ lib, config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -lat";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    profileExtra = ''
      if [ -z "$DESKTOP_SESSION" ] && [[ "$XDG_SESSION_TYPE" == "tty" ]]; then
          exec Hyprland
      fi
    '';

    initExtra = ''
      comp() {
          g++ "$1.cpp" -o $1 -Wall -Wextra -pedantic -std=c++20 -O2 -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fstack-protector
      }
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "clean";
    };
  };
}
