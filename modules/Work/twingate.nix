{ self, inputs, pkgs, ... }: {
  flake.nixosModules.twingate = { pkgs, lib, ... }: {
    environment.systemPackages = [
      pkgs.twingate
    ];
    services.twingate = {
      enable = true;
    };
  };
}
