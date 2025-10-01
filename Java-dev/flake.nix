{
    description = "Java-dev env w/ openjdk24 & maven, set up so maven packages may install without issues";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
    in
    {
        devShells.${system}.default = pkgs.mkShell {
            buildInputs = [
                pkgs.jdk24
                pkgs.maven
            ];
            shellHook = ''
                mkdir -p /tmp/maven-packages
                export MAVEN_OPTS="-Dmaven.repo.local=/tmp/maven-packages"

                echo "Java development environment ready"
                echo "MAVEN_OPTS set to /tmp/maven-packages"
            '';
        };
    };
}
