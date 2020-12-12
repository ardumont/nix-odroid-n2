self: super:
{

  linuxPackages_odroid_n2_5_4 = self.linuxPackagesFor (
    super.callPackage ./linux_odroid_n2/linux-5.4.nix { pkgs = self; }
  );

  linuxPackages_odroid_n2_5_6 = self.linuxPackagesFor (
    super.callPackage ./linux_odroid_n2/linux-5.6.nix { pkgs = self; }
  );

  linuxPackages_odroid_n2_5_9 = self.linuxPackagesFor (
    super.callPackage ./linux_odroid_n2/linux-5.9.nix { pkgs = self; }
  );

  uboot_odroid_n2 = super.callPackage ./uboot_odroid_n2 {};
}
