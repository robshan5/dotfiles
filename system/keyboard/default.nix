{config, pkgs, lib, input, ... }:

{
    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "ie";
        variant = "";
    };

    # Configure console keymap
    console.keyMap = "ie";

    services.keyd = {
        enable = true;
        keyboards = {
            # The name is just the name of the configuration file, it does not really matter
            default = {
                ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
                # Everything but the ID section:
                settings = {
                    # The main layer, if you choose to declare it in Nix
                    main = {
                        capslock = "esc";
                    };
                };
            };
        };
    };
}
