self: {
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.apex-tux;
in {
  options.programs.apex-tux = {
    enable = lib.mkEnableOption "apex-tux";
    package = lib.mkPackageOption self.packages.${pkgs.hostPlatform.system} "apex-tux";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [cfg.package];

    # https://github.com/not-jan/apex-tux/issues/70
    users.groups.plugdev = {};
    services.udev.extraRules = let
      script = pkgs.writers.writePython3 "steelseries-perms" {} ./steelseries-perms.py;
    in ''
      ACTION=="add", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1038" RUN+="${script} '%E{DEVNAME}'"
    '';
  };
}
