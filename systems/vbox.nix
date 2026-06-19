# Lightweight guest target for testing this flake inside VirtualBox itself.
#
# SETUP (one-time, before this config can be built):
#   1. Boot the NixOS installer ISO inside a new VirtualBox VM.
#   2. Partition/mount disks as usual.
#   3. Run: nixos-generate-config --root /mnt
#   4. Copy the generated /mnt/etc/nixos/hardware-configuration.nix into
#      this repo as systems/vbox-hardware-configuration.nix
#   5. sudo nixos-install --flake .#vbox
#
# After install, rebuild from inside the VM like any other target:
#   sudo nixos-rebuild switch --flake .#vbox
{ pkgs, inputs, ... }:
{
  _module.args = { inherit inputs; };

  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../modules/config-apps
    ./vbox-hardware-configuration.nix   # generated per-VM, see note above
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # NOTE: enable EFI in the VM's VirtualBox settings (System > Enable EFI),
  # or swap the two lines above for `boot.loader.grub.enable = true;` if using BIOS.

  # VirtualBox guest integration (clipboard sharing, shared folders, dynamic resolution)
  virtualisation.virtualbox.guest = {
    enable = true;
    x11 = true;   # set false if you only test headless/TTY
  };

  networking.networkmanager.enable = true;

  # Same desktop stack as your real machines, so dotfiles/config-apps behave identically
  # Hyprland enabled + keybinds defined once in modules/config-apps/hyprland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages =
    (import ../packages/common.nix pkgs)
    ++ (import ../packages/vbox.nix pkgs);
    # deliberately omit desktop.nix/framework.nix package sets – keep the VM lean

  nixpkgs.config.allowUnfree = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.yourname = {          # ← CHANGE TO YOUR USERNAME
      home.stateVersion = "26.05";

      programs.git = {
        enable = true;
        userName = "damien-bafile";
        userEmail = "bafile.damien@gmail.com";
      };
    };

    # VirtualBox's virtual display usually shows up as "Virtual-1". Using
    # "preferred" lets Hyprland pick whatever resolution the VM window is
    # currently sized to rather than hardcoding one — handy since you'll
    # likely be resizing the VirtualBox window a lot while testing.
    sharedModules = [{
      wayland.windowManager.hyprland.settings.monitor = [
        "Virtual-1, preferred, 0x0, 1"
      ];
    }];
  };
}
