{ config, lib, pkgs, ... }:

let
  cfg = config.adaspalsistema;
in
{
  options.adaspalsistema = {
    enable = lib.mkEnableOption "Enable Adaspal's HTTPD config.";
  };
  
  config = lib.mkIf cfg.enable {
    # Installs apache-httpd
    environment.systemPackages = [
      pkgs.apacheHttpd
      pkgs.dbeaver
    ];

    services.httpd = let
      # using pkgs2 to avoid recursive loop with fetchFromGitHub
      # see https://stackoverflow.com/questions/73097604/nixos-how-to-import-some-configuration-from-gitlab-infinite-recursion-encounte
      pkgs2 = (import <nixpkgs> { });
      nix-phps = pkgs2.fetchFromGitHub {
        owner = "fossar";
        repo = "nix-phps";
        rev = "ac2bb3d416a10fc66d0148dddc63a19c6c5a907c";
        hash = "sha256-74kQIFf3Cu1aeOsohCiLuA1aXNGYt2U9tTUP0yvm4EA=";
      };
      phps = import nix-phps;
    in
    { 
      enable = true;
      enablePHP = true;
      phpPackage = phps.packages.x86_64-linux.php74.buildEnv {
        extensions = { enabled, all }: enabled ++ (with all; [ 
          imagick opcache pdo session pdo_mysql filter 
          curl dom mbstring 
        ]);
        extraConfig = "memory_limit=32M; display_errors=1;";
      };
      user = "rafael";

      virtualHosts.localhost = {
          documentRoot = "/home/rafael/proyectos";
          extraConfig = ''<Directory /home/rafael/proyectos>
            Options Indexes FollowSymLinks Includes ExecCGI
            AllowOverride All
            Require all granted
            Allow from all
          </Directory>'';
      };
    };

    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureDatabases = [ "adaspal1_gestion" ];
      ensureUsers = [
        {
          name = "root";
          ensurePermissions = { "*.*" = "ALL PRIVILEGES"; }; 
        }
      ];
    };
  };
}
