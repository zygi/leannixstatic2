{
  description = "TODO";

  inputs.lean.url = github:zygi/lean4;
  inputs.flake-utils.url = github:numtide/flake-utils;
  inputs.lean-nix-static-1.url = github:zygi/leannixstatic1;

  outputs = { self, lean, nixpkgs, flake-utils, lean-nix-static-1}: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        leanPkgs = lean.packages.${system};
        pkg = leanPkgs.buildLeanPackage {
          name = "LeanNixStatic2";
          src = ./.;
          # No automatic inheriting -- if we want a Lean package to provide all
          # three kinds of deps, we have to list the dependencies separately. 
          deps = [ lean-nix-static-1.packages.${system} ];
          # For `staticLibDeps`, each derivation should contain a static library
          # in `${deriv}/lib${static.name}.a`. 
          staticLibDeps = [ lean-nix-static-1.packages.${system}.staticLib ];
          # For `pluginDeps`, each derivation should contain a static library in
          # `${deriv}/lib${static.name}.a`. 
          pluginDeps = [ lean-nix-static-1.packages.${system}.plugin ];
        };
      in {
        packages = pkg // {
          inherit (leanPkgs) lean;
        };

        defaultPackage = pkg.modRoot;
      }
    );
}

