{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./user/programs/bash/default.nix
    ./user/programs/sway/default.nix
    ./user/programs/kitty/default.nix
    ./user/programs/nvim/default.nix
    ./user/programs/rofi/default.nix
    ./user/programs/polybar/default.nix
    ./user/programs/yazi/default.nix
    ./user/programs/waybar/default.nix
    ./user/programs/firefox/default.nix
    inputs.textfox.homeManagerModules.default
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "robshan";
  home.homeDirectory = "/home/robshan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfreePredicate = _: true;
  home.packages = with pkgs; [
    #window managers
    i3
    sway

    #status bars
    waybar
    polybar

    #programs
    # firefox
    kitty
    rofi
    vim
    vlc
    yazi
    transmission_4-gtk
    spotify
    spotify-cli-linux
    
    #utilities
    picom
    wget
    git
    unzip
    zip
    zoxide
    feh
    swaybg
    starship
    wl-clipboard
    xwayland
    gtk-layer-shell
    noto-fonts
    font-awesome
    jq
    luajit
    lua52Packages.luaffi

    #fonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.keyboard.layout = "uk";

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/robshan/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  #Setting system theme

  #i3 config
  # home.file.".config/i3/config".source = ./dotfiles/.config/i3/config;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
