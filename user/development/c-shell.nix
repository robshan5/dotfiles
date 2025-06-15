{pkgs ? import <nixpkgs> { } }:

pkgs.mkShell
{
  nativeBuildInputs = with pkgs;[
    clang
    clang-tools
    cmake
    gdb
    clang-tidy-sarif
    gnumake
  ];

  shellHook = ''
    echo "C shell initialised"
  '';
}
