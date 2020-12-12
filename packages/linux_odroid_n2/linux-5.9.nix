{ stdenv, callPackage, ubootTools, pkgs, ... } @ args:

with (import ./patch/default.nix stdenv.lib);

let kernel-path = "${toString pkgs.path}/pkgs/os-specific/linux/kernel/linux-5.9.nix";
    kernel-pkgs = import kernel-path;
in callPackage ./configure.nix {

  inherit stdenv ubootTools;

  configfile = ./linux-5.4.config;

  kernel = callPackage kernel-pkgs {
    kernelPatches = (patchsets [
      "armbian/5.4"
      "libre/5.4"
    ]);

    NIX_CFLAGS_COMPILE = toString [
      "-mcpu=native"
    ];
  };
}
