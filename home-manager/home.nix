{

  imports = [
    ./zsh.nix
    ./modules/bundle.nix
  ];

  home = {
    username = "jondaw";
    homeDirectory = "/home/jondaw";
    stateVersion = "23.11";
  };
}
