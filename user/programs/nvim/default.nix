{ pkgs, lib, vars, inputs, ...}:
let
    themeLua = pkgs.writeText "theme.lua" (
        import ./theme-lua.nix {
            inherit lib;
            theme = vars.theme;
        }
    );

    # The tracked config plus the palette generated from vars.theme, so
    # colors/dotfiles.lua can `require("theme")`.
    nvimConfig = pkgs.runCommandLocal "nvim-config" { } ''
        cp -r ${./nvim} $out
        chmod -R u+w $out
        install -Dm444 ${themeLua} $out/lua/theme.lua
    '';
in 
    {
    home = {
        packages = with pkgs;[
            #for telescope grepping
            ripgrep
            #lua
            lua
            lua-language-server
            stylua
            #nix
            nil
            nixd

            gcc
            gdb
            clang-tidy-sarif
            gnumake
        ];
        file = {
            ".config/nvim" = {
                source = nvimConfig;
            };
        };
    };

    programs.neovim = {
        defaultEditor = true;
        enable = true;
        viAlias = true;
        vimAlias = true;

        extraPython3Packages = ps: with ps; [
            pynvim
            ipykernel
            ipython
            jupyter-client
        ];

        plugins = with pkgs.vimPlugins; [
            nvim-cmp
            cmp-nvim-lsp
            nvim-lspconfig
            nvim-snippy
            noice-nvim

            (pkgs.vimUtils.buildVimPlugin {
                pname = "magma-nvim";
                version = "latest";

                src = pkgs.fetchFromGitHub {
                    owner = "robshan5";
                    repo = "magma-nvim";
                    rev = "main";
                    sha256 = "sjb/bDaSTJhA08+k6FknICgQ8UUT7z95Nr/B2dhnTr8="; # will fail first time, then fill in
                };
            })
        ];
    };
}
