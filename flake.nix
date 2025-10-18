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

        # ------------------------

        export PYTHONUSERBASE=/tmp/pip-packages
        export PIP_TARGET=/tmp/pip-packages

        # export MAVEN_OPTS="-Dmaven.repo.local=/tmp/maven-packages"

        # ------------------------
                
        echo "PYTHONUSERBASE and PIP_TARGET set to /tmp/pip-packages"
        echo "MAVEN_OPTS set to /tmp/maven-packages"

        # ------------------------

        python3 -m pip install -r requirements.txt
        python3 app.py

        java App.java
      '';
    };
  };
}
