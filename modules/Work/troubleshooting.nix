{ self, inputs, pkgs, ... }: {
  flake.nixosModules.troubleshooting = { pkgs, lib, ... }: {
    environment.systemPackages = [
      pkgs.zenmap
      pkgs.angryipscanner
      pkgs.inetutils
    ];
  };
}
