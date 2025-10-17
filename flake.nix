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

                pkgs.maven
                pkgs.jdk25
            ];
            shellHook = ''
                mkdir -p /tmp/pip-packages
                mkdir -p /tmp/maven-packages

                export PYTHONUSERBASE=/tmp/pip-packages
                export PIP_TARGET=/tmp/pip-packages

                export MAVEN_OPTS="-Dmaven.repo.local=/tmp/maven-packages"

                # --------
                
                echo "Python development environment ready"
                echo "PYTHONUSERBASE and PIP_TARGET set to /tmp/pip-packages"

                echo "Java development environment ready"
                echo "MAVEN_OPTS set to /tmp/maven-packages"

                echo "C/C++ development environment ready"
            '';
        };
    };
}
