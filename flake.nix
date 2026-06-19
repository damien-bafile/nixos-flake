{
  description = "Multi‑system flake: desktop, framework, vbox test VM, Mac – hybrid modular";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    emacs-config.url = "github:damien-bafile/emacs-config";
    emacs-config.flake = false;   # raw source tree

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    # Do NOT override its nixpkgs input — keeps kernel patches in sync with kernel version.
  };

  outputs = { nixpkgs, nix-darwin, home-manager, ... }@inputs:
  {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./systems/desktop.nix ];
    };

    nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./systems/framework.nix ];
    };

    nixosConfigurations.vbox = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./systems/vbox.nix ];
    };

    darwinConfigurations.mac = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";   # change to x86_64-darwin for Intel Macs
      specialArgs = { inherit inputs; };
      modules = [ ./systems/mac.nix ];
    };
  };
}
