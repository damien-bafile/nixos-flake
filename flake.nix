{
  description = "NixOS with Cosmic Desktop";

  inputs = {
    # Use unstable to get cosmic
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      flake-utils,
      home-manager,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixos-hardware home-manager; };
          modules = [
            ./hosts/nixos
          ];
        };
      };

      # Development shell for flake maintenance
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.nixos-rebuild
          pkgs.home-manager
          pkgs.git
        ];
      };
    };
}
