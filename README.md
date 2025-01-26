* Installation
  - Install nixos, git and vim
  - Copy these commands to install home-manager (this is for 24.11 so check if you need to update the version your downloading)
    ```
    nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
    ```
  - Then clone the repo in ~/
    ```
    git clone https://github.com/robshan5/dotfiles
    ```
    Hopefully this works :)
