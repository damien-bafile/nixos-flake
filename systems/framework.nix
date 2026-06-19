{ pkgs, inputs, ... }:
{
  _module.args = { inherit inputs; };

  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../modules/config-apps
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.graphics.enable = true;

  # CachyOS kernel: BORE scheduler + x86_64-v3 microarch optimization.
  # 12th Gen Intel (Alder Lake) supports AVX2/BMI2/FMA, so v3 is safe here.
  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-x86_64-v3;
  nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
  nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

  # ananicy-cpp: auto-renices foreground/heavy processes, deprioritizes background ones
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
  };

  # zram swap — particularly useful on laptops with less RAM than the desktop
  zramSwap.enable = true;

  # Laptop power management
  services.tlp.enable = true;
  services.powertop.enable = true;

  # Hyprland enabled + keybinds defined once in modules/config-apps/hyprland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.steam.enable = true;   # optional – remove if not needed

  # VirtualBox
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };
  users.users.yourname.extraGroups = [ "vboxusers" ];   # ← CHANGE TO YOUR USERNAME

  environment.systemPackages =
    (import ../packages/common.nix pkgs)
    ++ (import ../packages/framework.nix pkgs);
    # No CUDA, no ollama

  nixpkgs.config.allowUnfree = true;   # Steam, VirtualBox ext pack

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.yourname = {          # ← CHANGE TO YOUR USERNAME
      home.stateVersion = "26.05";
    };

    # Framework 13's built-in panel — run `hyprctl monitors` to get the
    # real output name (likely eDP-1) and resolution/scale.
    # Format: "name, resolution@refresh, position, scale"
    sharedModules = [{
      wayland.windowManager.hyprland.settings.monitor = [
        # TODO: RESOLUTION HERE — e.g. "eDP-1, 2256x1504@60, 0x0, 1.5"
      ];
    }];
  };
}
