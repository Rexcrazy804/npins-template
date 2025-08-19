{packages, ...}: {
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf attrValues;
in {
  options.cowMod.enable = mkEnableOption "cow";
  config = mkIf (config.cowMod.enable) {
    environment.systemPackages = attrValues {
      inherit (packages) cowask lolask;
    };
  };
}
