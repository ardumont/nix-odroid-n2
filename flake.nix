{
  description = "nix-odroid-n2 flake";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      # ref = "6afba54ead2ce4cb32ffc27c3f7d7358b37697ca";  # for linux-5.6.nix
      ref = "nixos-unstable";
    };

    flake-utils = {
      type = "github";
      owner = "numtide";
      repo = "flake-utils";
      ref = "master";
    };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let overlay = ( import ./packages );
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ overlay ];
          };
      in rec {
        inherit overlay;
        packages = flake-utils.lib.flattenTree {
          odroid-n2-kernel-5-4 = pkgs.linuxPackages_odroid_n2_5_4.kernel;
          odroid-n2-kernel-5-9 = pkgs.linuxPackages_odroid_n2_5_9.kernel;
          uboot_odroid_n2 = pkgs.uboot_odroid_n2;
        };

        defaultPackage = packages.odroid-n2-kernel-5-6;
      }
    );

  # nix build
  # nix build .#packages.aarch64-linux.odroid-n2-kernel-5-6
  # ...
}
