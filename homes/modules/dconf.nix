{ lib, config, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      edge-tiling = true;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/amber-l.png";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/amber-d.png";
    };
    "org/gnome/desktop/peripherals/keyboard" = {
      repeat-interval = "uint32 30";
      repeat-delay = "uint32 250";
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "caps:swapescape"
      ];
      sources = [
        (lib.hm.gvariant.mkTuple ["xkb" "us"])
        (lib.hm.gvariant.mkTuple ["xkb" "bg+phonetic"])
      ];
    };
  };
}
