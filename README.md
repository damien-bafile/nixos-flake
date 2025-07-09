# NixOS Flake Configuration

This repository contains a modular NixOS flake configuration with the Cosmic Desktop environment.

## Structure

```
/etc/nixos/
├── flake.nix               # Main flake configuration
├── flake.lock              # Flake lock file
├── hardware-configuration.nix  # Auto-generated hardware config
├── hosts/
│   └── nixos/
│       └── default.nix     # Host-specific configuration
├── modules/
│   ├── boot.nix            # Boot loader configuration
│   ├── desktop.nix         # Desktop environment (Cosmic)
│   ├── networking.nix      # Network configuration
│   └── system.nix          # System-wide settings
└── users/
    └── daimyo/
        ├── default.nix     # User account configuration
        └── home.nix        # Home Manager configuration
```

## Getting Started

### Prerequisites
- NixOS installed
- Nix flakes and the experimental features enabled

### Clone the Repository
```bash
git clone https://github.com/your-username/your-repository.git /etc/nixos
```

### Rebuild System
```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

### Update Flake Inputs
```bash
cd /etc/nixos
sudo nix flake update
```

### Enter Development Shell
```bash
cd /etc/nixos
nix develop
```

## Customization

- **Add New Hosts**: Create a new directory under `hosts/` and add it to `flake.nix`
- **Add New Users**: Create a new directory under `users/` and import it in the host configuration
- **Modify System Settings**: Edit the appropriate module in `modules/`
- **Customize User Environment**: Edit `users/daimyo/home.nix`

## Notes

- The configuration uses NixOS unstable to get the Cosmic desktop environment
- Home Manager is integrated for user-specific configuration
- Flatpak is enabled for additional application support
- The system is configured for a Framework 12th gen Intel laptop
