{ lib, config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix        = "C-b";
    keyMode       = "vi";
    mouse         = true;
    baseIndex     = 1;
    historyLimit  = 50000;
    escapeTime    = 0;
    terminal      = "tmux-256color";
    focusEvents   = true;
    clock24       = true;

    extraConfig = ''
      set -ga terminal-overrides ",xterm-ghostty:Tc"
      set -sg repeat-time 600
      setw -g pane-base-index 1
      set -g renumber-windows on
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi r send -X rectangle-toggle
      set -g status-interval 5
      set -g status-left-length 20
      set -g status-left "#[bold] #S "
      set -g status-right "%Y-%m-%d %H:%M"
      setw -g window-status-current-format "#[bold] #I:#W "
    '';
  };
}
