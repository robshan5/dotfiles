{ pkgs, ...}:
let
  nvimConfig = ./nvim;
in 
{
  home = {
    packages = with pkgs;[
      #lua
      lua-language-server
      stylua
      #nix
      nil
      nixd
      #java
      openjdk11
      jdt-language-server
      #python
      pyright
      black
      isort
      #rust
      rust-analyzer
      #c
      clang
      libclang
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

    plugins = 
      with pkgs.vimPlugins;
    [
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
      neorg
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
    ];
  };
}
