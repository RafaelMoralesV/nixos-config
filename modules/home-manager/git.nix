{ pkgs, ... }:

{
  home.packages = [ pkgs.git ];
  programs.git = {
    enable = true;
    userName = "Rafael Morales";
    userEmail = "rmorales@utem.cl";
  };
}
