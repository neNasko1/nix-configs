{ lib, config, pkgs, ... }:

let custom = {
  font = "JetBrainsMono Nerd Font";
  font_size = "18px";
  font_weight = "bold";
  text_color = "#FBF1C7";
  background_0 = "#1D2021";
  background_1 = "#282828";
  border_color = "#928374";
  red = "#CC241D";
  green = "#98971A";
  yellow = "#FABD2F";
  blue = "#458588";
  magenta = "#B16286";
  cyant = "#689D6A";
  orange = "#D65D0E";
  opacity = "1";
  indicator_height = "2px";
};
in 
  {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });

    style = with custom; ''
      * {
  border: none;
  border-radius: 0px;
  padding: 0;
  margin: 0;
  font-family: ${font};
  font-weight: ${font_weight};
  opacity: ${opacity};
  font-size: ${font_size};
      }

      window#waybar {
  background: #282828;
      }

      tooltip {
  background: ${background_1};
  border: 1px solid ${border_color};
      }
      tooltip label {
  margin: 5px;
  color: ${text_color};
      }

      #workspaces {
  padding-left: 15px;
      }
      #workspaces button {
  color: ${yellow};
  padding-left:  5px;
  padding-right: 5px;
  margin-right: 10px;
  border-bottom: ${indicator_height} solid ${background_0};
      }
      #workspaces button.empty {
  color: ${text_color};
      }
      #workspaces button.active {
  color: ${yellow};
  border-bottom: ${indicator_height} solid ${yellow};
      }

      #clock {
  color: ${text_color};
  border-bottom: ${indicator_height} solid ${background_0};
      }

      #pulseaudio, #network, #battery, #custom-notification {
  padding-left: 5px;
  padding-right: 5px;
  margin-right: 10px;
  color: ${text_color};
      }

      #pulseaudio {
  margin-left: 15px;
  border-bottom: ${indicator_height} solid ${blue};
      }
      #network {
  border-bottom: ${indicator_height} solid ${magenta};
      }
      #battery {
  border-bottom: ${indicator_height} solid ${yellow};
      }

      #custom-notification {
  margin-left: 15px;
  padding-right: 2px;
  margin-right: 5px;
  border-bottom: ${indicator_height} solid ${red};
      }

      #custom-launcher {
  font-size: 20px;
  color: ${text_color};
  font-weight: bold;
  margin-left: 15px;
  padding-right: 10px;
  border-bottom: ${indicator_height} solid ${background_0};
      }
    '';

    settings.mainBar = with custom; {
      position= "bottom";
      layer= "top";
      height= 25;
      margin-top= 0;
      margin-bottom= 0;
      margin-left= 0;
      margin-right= 0;
      modules-left= [
        "hyprland/workspaces"
      ];
      modules-center= [
        "clock"
      ];
      modules-right= [
        "pulseaudio" 
        "network"
        "battery"
        "custom/notification"
      ];
      clock= {
        calendar = {
          format = { today = "<span color='#98971A'><b>{}</b></span>"; };
        };
        tooltip = false;
        format = "  {:%H:%M}";
        format-alt= "  {:%d/%m}";
      };
      "hyprland/workspaces"= {
        active-only= false;
        disable-scroll= true;
        format = "{icon}";
        on-click= "activate";
        format-icons= {
          "1"  = "I";
          "2"  = "II";
          "3"  = "III";
          "4"  = "IV";
          "5"  = "V";
          "6"  = "VI";
          "7"  = "VII";
          "8"  = "VII";
          "9"  = "IX";
          "10" = "X";
          sort-by-number= true;
        };
        persistent-workspaces = {
          "1"= [];
          "2"= [];
          "3"= [];
          "4"= [];
          "5"= [];
        };
      };
      network = {
        format-wifi = "<span foreground='${magenta}'> </span> {signalStrength}%";
        format-ethernet = "<span foreground='${magenta}'>󰀂 </span>";
        tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "<span foreground='${magenta}'>󰖪 </span>";
      };
      pulseaudio= {
        format= "{icon} {volume}%";
        format-muted= "<span foreground='${blue}'> </span> {volume}%";
        format-icons= {
          default= ["<span foreground='${blue}'> </span>"];
        };
        scroll-step= 2;
        on-click= "pamixer -t";
      };
      battery = {
        format = "<span foreground='${yellow}'>{icon}</span> {capacity}%";
        format-icons = [" " " " " " " " " "];
        format-charging = "<span foreground='${yellow}'> </span>{capacity}%";
        format-full = "<span foreground='${yellow}'> </span>{capacity}%";
        format-warning = "<span foreground='${yellow}'> </span>{capacity}%";
        interval = 5;
        states = {
          warning = 20;
        };
        format-time = "{H}h{M}m";
        tooltip = true;
        tooltip-format = "{time}";
      };
    };
  };

}
