{

    description = "Desktop Flake";

    inputs = {
        # Release channels. These track the current NixOS stable release and are
        # independent of vars.stateVersion (which must stay at the install-time value).
        nixpkgs.url = "nixpkgs/nixos-26.05";
        home-manager.url = "github:nix-community/home-manager/release-26.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs = {
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
            vars = import ./vars.nix;
            cShell = import ./user/development/c-shell.nix {inherit pkgs;};
            # pythonShell = import ./user/development/python-shell.nix {inherit pkgs;};
        in {
            # SYSTEM ACCOUNTS
            # Keyed by hostname so `nixos-rebuild switch --flake .#$(hostname)` works.
            nixosConfigurations = {
                ${vars.hostnames.laptop} = lib.nixosSystem {
                    inherit system;
                    specialArgs = { inherit inputs vars; };
                    modules = [
                        ./hosts/Lugh/configuration.nix
                    ];
                };

                ${vars.hostnames.server} = lib.nixosSystem {
                    inherit system;
                    specialArgs = { inherit inputs vars; };
                    modules = [
                        ./hosts/Dullahan/configuration.nix
                    ];
                };

                ${vars.hostnames.desktop} = lib.nixosSystem {
                    inherit system;
                    specialArgs = { inherit inputs vars; };
                    modules = [
                        ./hosts/Balor/configuration.nix
                    ];
                };
            };

            # HOME MANAGER ACCOUNTS
            homeConfigurations = {
                "${vars.username}@${vars.hostnames.laptop}" = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [
                        {
                            home.username = vars.username;
                            home.homeDirectory = "/home/${vars.username}";
                        }
                        ./accounts/robshan.nix
                    ];
                    extraSpecialArgs = {inherit inputs vars; };
                };

                "${vars.username}@${vars.hostnames.desktop}" = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [
                        {
                            home.username = vars.username;
                            home.homeDirectory = "/home/${vars.username}";
                        }
                        ./accounts/robshan.nix
                    ];
                    extraSpecialArgs = {inherit inputs vars; };
                };

                ${vars.serverUsername} = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [
                        {
                            home.username = vars.serverUsername;
                            home.homeDirectory = "/home/${vars.serverUsername}";
                        }
                        ./accounts/nix_server.nix
                    ];
                    extraSpecialArgs = {inherit inputs vars; };
                };
            };
            devShells.${system} = {
                c = cShell;  # Reference the C development shell
                # python = pythonShell;  # Reference the Python development shell
            };
        };

}
