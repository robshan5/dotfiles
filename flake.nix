{
    
  description = "Desktop Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, home-manager, ...}@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      robertNix = lib.nixosSystem {
        inherit system;
        modules = [
         ./configuration.nix
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
    homeConfigurations = {
      robshan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ./user/programs/bash/default.nix
          ./user/programs/sway/default.nix
          ./user/programs/kitty/default.nix
          ./user/programs/nvim/default.nix
          ./user/programs/rofi/default.nix
          ./user/programs/polybar/default.nix
          ./user/programs/yazi/default.nix
          ./user/programs/waybar/default.nix
        ];
      };
    };
    devShells.x86_64-linux.default = (import ./user/development/python/shell.nix {inherit pkgs; });
  };

}
