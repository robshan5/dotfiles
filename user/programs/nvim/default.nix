{ pkgs, inputs, ...}:
let
    nvimConfig = ./nvim;
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
            #python
            # pyright
            # black
            # isort
            #c
            clang
            clang-tools
            cmake
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
