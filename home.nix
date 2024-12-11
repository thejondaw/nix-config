{ config, pkgs, ... }:

{
  imports = [ ./gnome.nix ];

  # NixOS - Unfree Packages
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "jondaw";
    homeDirectory = "/home/jondaw";
    stateVersion = "24.11";
    };

  # Git - Settings
  programs.git = {
    enable = true;
    userName = "thejondaw";
    userEmail = "mrjondaw@gmail.com";
  };
}