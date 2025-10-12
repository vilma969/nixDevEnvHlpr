{
    description = "C/C++-dev env w/ gcc & gdb";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
    in
    {
        devShells.${system}.default = pkgs.mkShell {
            buildInputs = [
                pkgs.vscode-fhs
                pkgs.gcc
                pkgs.gdb
            ];
            shellHook = ''
                echo "C/C++ development environment ready"
            '';
        };
    };
}
