# Dotfiles

My personal NixOS configuration, managed with Nix Flakes and Home Manager. The config is structured around separate host and user profiles, making it easy to replicate across multiple machines.

## Structure

```
dotfiles/
├── accounts/       # User account definitions
├── hosts/          # Per-machine hardware and system configuration
├── system/         # Shared system-level NixOS modules
├── user/           # Shared user-level Home Manager modules
├── flake.nix       # Flake entrypoint — defines hosts and users
├── home.nix        # Home Manager configuration root
└── configuration.nix
```

## Setup

This guide covers setting up the config on a fresh NixOS install.

### 1. Enable Flakes

Add flake support to `/etc/nixos/configuration.nix`:

```nix
nix.settings.experimental-features = ["nix-command" "flakes"];
```

Then rebuild and make sure git is installed:

```bash
sudo nixos-rebuild switch
```

### 2. Clone and Apply System Config

Clone this repo to your home directory:

```bash
git clone https://github.com/robshan5/dotfiles
cd dotfiles
```

Rebuild the system using the flake, specifying your host:

```bash
sudo nixos-rebuild switch --flake .#[host]
```

> Replace `[host]` with the name of your machine as defined in `hosts/`. For example: `.#desktop` or `.#laptop`.

### 3. Set Up Home Manager

Add the Home Manager channel, making sure the version matches your NixOS release:

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
nix-channel --update
```

> For NixOS unstable, use `master.tar.gz` instead of `release-25.11.tar.gz`.

Install Home Manager:

```bash
nix-shell '<home-manager>' -A install
```

Apply the Home Manager config for your user:

```bash
home-manager switch --flake .#[user]
```

> Replace `[user]` with your username as defined in `accounts/`. For example: `.#robshan`.

## Requirements

- A fresh [NixOS](https://nixos.org/) installation
- Internet connection for fetching packages
