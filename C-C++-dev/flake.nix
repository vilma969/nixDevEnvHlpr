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
                pkgs.vscode-fhs
                pkgs.gcc
                pkgs.gdb
            ];
            shellHook = ''
                if [ "$(id --user)" -eq 0 ]; then
                    SIMULATED_USER=devuser
                    SIMULATED_HOME="$PWD/.${SIMULATED_USER}"

                    export USER="$SIMULATED_USER"
                    export LOGNAME="$SIMULATED_USER"

                    mkdir -p "$SIMULATED_HOME"
                    export HOME="$SIMULATED_HOME"
                fi

                echo "C/C++ development environment ready"
            '';
        };
    };
}
