{modulesPath, ...}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    (modulesPath + "/virtualisation/qemu-vm.nix")
  ];

  networking.hostName = "cowHost";
  system.stateVersion = "25.05";
  virtualisation = {
    graphics = false;
    diskSize = 10 * 1024;
    memorySize = 2 * 1024;
    cores = 2;
  };

  security.sudo.wheelNeedsPassword = false;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  users.users.rexies = {
    enable = true;
    initialPassword = "kokomi";
    createHome = true;
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = [];
  };

  # <>< kokomi was here
  cowMod.enable = true;
}
