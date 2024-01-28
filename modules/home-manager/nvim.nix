{ pkgs, ... }:

# Esto deberia ser NixVim
{
  home.packages = with pkgs; [ 
    nerdfonts
    ripgrep
    lazygit
    godu
    bottom
  ];
}
