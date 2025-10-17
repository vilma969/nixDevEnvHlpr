{
    description = "Python-dev env w/ python3.13 & pip, set up so pip packages may install without issues";

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
                pkgs.python313
                pkgs.python313Packages.pip
            ];
            shellHook = ''
                mkdir -p /tmp/pip-packages
                export PYTHONUSERBASE=/tmp/pip-packages
                export PIP_TARGET=/tmp/pip-packages

                if [ "$(id --user)" -eq 0 ]; then
                    SIMULATED_USER=devuser
                    SIMULATED_HOME="$PWD/.${SIMULATED_USER}"

                    export USER="$SIMULATED_USER"
                    export LOGNAME="$SIMULATED_USER"

                    mkdir -p "$SIMULATED_HOME"
                    export HOME="$SIMULATED_HOME"
                fi
                
                echo "Python development environment ready"
                echo "PYTHONUSERBASE and PIP_TARGET set to /tmp/pip-packages"
            '';
        };
    };
}
