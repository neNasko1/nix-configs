{ lib, config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "nasko119@gmail.com";
    userName = "neNasko1";
  };
}
