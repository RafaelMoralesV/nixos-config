{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, ... } @ inputs: let
      myLib = import ./myLib/default.nix { inherit inputs; };
  in
    with myLib; {

      nixosConfigurations = {
        default = mkSystem ./hosts/default/configuration.nix;
      };

      homeConfigurations = {
        "rafael@nixos" = mkHome "x86_64-linux" ./hosts/default/home.nix;
      };

      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
    };
}
