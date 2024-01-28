{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
    nerdfonts
    ripgrep
    lazygit
    godu
    bottom
  ];
}
