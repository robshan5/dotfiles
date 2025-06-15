{
    
  description = "Desktop Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    textfox.url = "github:adriankarlen/textfox";
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ...}@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      cShell = import ./user/development/c-shell.nix {inherit pkgs;};
      # pythonShell = import ./user/development/python-shell.nix {inherit pkgs;};
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
        ];
        extraSpecialArgs = {inherit inputs; };
      };
    };
    devShells = {
      c = cShell;  # Reference the C development shell
      # python = pythonShell;  # Reference the Python development shell
    };
  };

}
