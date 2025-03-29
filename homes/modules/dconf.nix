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
      delay = "uint32 220";
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
    "org/gnome/Console" = {
      font-scale = 1.1;
      use-system-font = false;
      custom-font = "DroidSansM Nerd Font 10";
      visual-bell = false;
      audible-bell = false;
    };
    "org/gnome/desktop/notifications" = {
      show-banners = false;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "ghostty";
      name = "Open terminal";
    };
    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = false;
      power-saver-profile-on-low-battery = false;
      sleep-inactive-battery-type = "nothing";
      sleep-inactive-ac-type = "nothing";
    };
    "org/gnome/shell" = {
      last-selected-power-profile = "performance";
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 5;
    };
    "org/gnome/mutter" = {
      workspaces-only-on-primary = false;
    };
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
  };
}
