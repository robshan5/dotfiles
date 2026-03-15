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
            #java
            openjdk23
            jdt-language-server
            astyle
            #python
            pyright
            black
            isort
            python311Packages.pip
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

        extraPackages = with pkgs; [
            imagemagick
        ];
        extraPython3Packages = ps: with ps; [
            pynvim
            ipykernel
            ipython
            jupyter-client
            cairosvg
            pnglatex
            plotly
            pyperclip
        ];
        plugins = with pkgs.vimPlugins; [
            alpha-nvim
            nvim-autopairs
            indent-blankline-nvim
            nvim-cokeline
            catppuccin-nvim  
            comment-nvim
            compiler-nvim
            nvim-cmp
            cmp-nvim-lsp
            nvim-lspconfig
            lualine-nvim
            neo-tree-nvim
            noice-nvim
            nord-nvim
            nvim-notify
            oil-nvim
            onedark-nvim
            nvim-surround
            telescope-nvim
            toggleterm-nvim
            nvim-treesitter
            zoxide-vim
            nvim-snippy
            cmp-snippy
            gruvbox-nvim
            image-nvim
            diagflow-nvim
            typst-vim
            typst-preview-nvim

            # magma-nvim
            (pkgs.vimUtils.buildVimPlugin {
                pname = "magma-nvim";
                version = "latest";

                src = pkgs.fetchFromGitHub {
                    owner = "robshan5";
                    repo = "magma-nvim";
                    rev = "master";
                    sha256 = "1hvnyips9pb9kjb2wy9gxg8b4qiwmp9pf1jab64gzc10r2ax4hgi";
                };
            })
        ];
    };
}
