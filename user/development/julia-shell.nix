{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.julia.withPackages (ps: with ps; [
      LanguageServer
      SymbolServer
    ]))
  ];
}
