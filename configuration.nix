{ pkgs, ... }:
let
  sources = import ./nix/sources.nix;
in
{
  imports = [
    "${sources.nixos-hardware}/raspberry-pi/4"
  ];

  system.stateVersion = "22.05";

  nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  networking = {
    hostName = "nixos-raspi-4"; # Define your hostname.
    networkmanager = {
      enable = true;
    };
  };

  hardware.raspberry-pi."4".fkms-3d.enable = true;

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  users = {
    mutableUsers = true;
    users.nixos = {
      isNormalUser = true;
      initialPassword = "nixos";
      extraGroups = [ "wheel" ];
    };
  };
}
