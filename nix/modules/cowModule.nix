super: {
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf attrValues;
in {
  options.cowMod.enable = mkEnableOption "cow";
  config = mkIf (config.cowMod.enable) {
    environment.systemPackages = attrValues {
      inherit (super.packages) cowask lolask;
    };
  };
}
