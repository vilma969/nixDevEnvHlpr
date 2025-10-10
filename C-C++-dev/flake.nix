{
    description = "C/C++-dev env w/ gcc, gdb & make";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
    in
    {
        devShells.${system}.default = pkgs.mkShell {
            buildInputs = [
                pkgs.gcc
                pkgs.gdb
                pkgs.make
            ];
            shellHook = ''
                echo "C/C++ development environment ready"
            '';
        };
    };
}
