# my-flake

Multi-system Nix flake: desktop (NixOS), framework laptop (NixOS), a
VirtualBox test VM (NixOS), and a Mac (nix-darwin). Traditional flake
structure (not flake-parts).

## Before building

Replace `yourname` with your actual Unix username in:
- systems/desktop.nix
- systems/framework.nix
- systems/mac.nix
- systems/vbox.nix

## Build commands

```bash
sudo nixos-rebuild switch --flake .#desktop
sudo nixos-rebuild switch --flake .#framework
darwin-rebuild switch --flake .#mac
```

## VirtualBox test VM

`systems/vbox.nix` is a guest config for testing this flake inside
VirtualBox before touching real hardware. It needs a real
hardware-configuration.nix generated from inside an actual VM — see the
comment at the top of systems/vbox.nix for the full one-time setup steps.
systems/vbox-hardware-configuration.nix in this zip is a stub; replace it.

## Known TODO / not yet implemented

Two things were discussed but not yet applied to these files:

1. **flake-parts migration** — flake.nix is still the traditional
   `outputs = { ... }@inputs: { ... }` form, not restructured with
   flake-parts modules.
2. **nixvim replacement for Neovim** — modules/config-apps/neovim/default.nix
   still uses the original LazyVim-bootstrap-via-init.lua approach, not a
   nixvim-based declarative config replicating your Emacs setup.

Ask for either of these to be finished if you still want them.
