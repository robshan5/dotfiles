{

    description = "Desktop Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";
        home-manager.url = "github:nix-community/home-manager/release-25.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs = {
                # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
                # to have it up-to-date or simply don't specify the nixpkgs input
                nixpkgs.follows = "nixpkgs";
                home-manager.follows = "home-manager";
            };
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
            # SYSTEM ACCOUNTS
            nixosConfigurations = {
                laptop = lib.nixosSystem {
                    inherit system;
                    modules = [
                        ./hosts/laptop/configuration.nix
                    ];
                };

                server = lib.nixosSystem {
                    inherit system;
                    modules = [
                        ./hosts/server/configuration.nix
                    ];
                };
            };

            # HOME MANAGER ACCOUNTS
            homeConfigurations = {
                robshan = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [
                        {
                            home.username = "robshan";
                            home.homeDirectory = "/home/robshan";
                        }
                        ./accounts/robshan.nix
                    ];
                    extraSpecialArgs = {inherit inputs; };
                };

                nix_server = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [
                        {
                            home.username = "nix_server";
                            home.homeDirectory = "/home/nix_server";
                        }
                        ./accounts/nix_server.nix
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
