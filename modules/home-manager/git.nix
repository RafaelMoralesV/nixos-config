{ lib, config, ... }:

let
  cfg = config.git-config;
in
{
  options.git-config = {
    enable = lib.mkEnableOption "Enable my Git Config";
  };
  
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Rafael Morales";
      userEmail = "rmorales@utem.cl";
    };
  };
}
