# Helper, not a theme: resolves a theme's `fonts.packages` into derivations.
#
# Themes name their fonts as attribute-path strings (e.g. "maple-mono.NF") so
# they stay pure data that ../user/programs/nvim/theme-lua.nix can render into
# Lua. Both the NixOS font config and the Home Manager profile import this, so
# `home-manager switch` on its own is enough to install a new theme's fonts.
#
# A theme's `mono` / `nerd` must be the family names fontconfig reports for
# these packages, which often differ from the package name - check with
# `fc-list : family | grep -i <name>` before committing a new theme.
{ lib, pkgs, theme }:
map (
  path:
  lib.attrByPath (lib.splitString "." path)
    (throw "theme font package '${path}' does not exist in nixpkgs")
    pkgs
) theme.fonts.packages
