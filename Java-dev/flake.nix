{
    description = "Java-dev env w/ openjdk24 & maven, set up so maven packages may install without issues";

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
                pkgs.jdk25
                pkgs.maven
            ];
            shellHook = ''
                mkdir -p /tmp/maven-packages
                export MAVEN_OPTS="-Dmaven.repo.local=/tmp/maven-packages"

                if [ "$(id --user)" -eq 0 ]; then
                    SIMULATED_USER="devuser"
                    SIMULATED_HOME="$PWD/.${SIMULATED_USER}"

                    export USER="${SIMULATED_USER}"
                    export LOGNAME="${SIMULATED_USER}"

                    mkdir -p "${SIMULATED_HOME}"
                    export HOME="${SIMULATED_HOME}"
                fi

                echo "Java development environment ready"
                echo "MAVEN_OPTS set to /tmp/maven-packages"
            '';
        };
    };
}
