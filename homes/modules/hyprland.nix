{ lib, config, pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &&
    ${pkgs.swww}/bin/swww img ${./wallpapers/lake-sunset.jpg}
    '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      exec-once = ''${startupScript}/bin/start'';

      input = {
        "kb_options" = "caps:swapescape";
        "repeat_delay" = 250;
        "repeat_rate" = 50;
      };

      animations = {
        enabled = false;
      };

      "$mod" = "SUPER";
      "$menu" = "wofi --show drun";
      "$terminal" = "alacritty";

      general = {
        gaps_out = 8;
      };

      bind =
        [
          "$mod, RETURN, exec, $terminal"
          "$mod SHIFT, RETURN, exec, $menu"
          "$mod, Q, killactive"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          ) 10)
        );
    };
  };
}
