{
    description = "C/C++-dev env w/ gcc & gdb";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; };
    in
    {
        devShells.${system}.default = pkgs.mkShell {
            buildInputs = [
                pkgs.gcc
                pkgs.gdb
            ];
            shellHook = ''
                export PATH=$PATH:/home/afma/.vscode-server/bin/03c265b1adee71ac88f833e065f7bb956b60550a/bin/remote-cli/code
                echo "C/C++ development environment ready"
            '';
        };
    };
}
