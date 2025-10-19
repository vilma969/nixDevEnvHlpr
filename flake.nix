{
  description = "nixDevEnvHelper";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; };
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.vscodium-fhs

        pkgs.python313
        pkgs.python313Packages.pip

        pkgs.jdk25
        pkgs.maven

        pkgs.gcc
        pkgs.gdb
      ];
      shellHook = ''
        mkdir -p /tmp/pip-packages
        # mkdir -p /tmp/maven-packages

        mkdir -p /tmp/vscodium-data

        # ------------------------

        export PYTHONUSERBASE=/tmp/pip-packages
        export PIP_TARGET=/tmp/pip-packages

        # export MAVEN_OPTS="-Dmaven.repo.local=/tmp/maven-packages"

        # ------------------------
                
        echo "PYTHONUSERBASE and PIP_TARGET set to /tmp/pip-packages"
        # echo "MAVEN_OPTS set to /tmp/maven-packages"

        # ------------------------

        echo "Python dev env ready"
        # echo "Java dev env ready"

        # ------------------------

        bash start.sh
      '';
    };
  };
}
