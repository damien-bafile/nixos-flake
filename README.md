# NixOS Multi-Host Configuration

This flake provides NixOS configurations for multiple systems with different hardware requirements.

## Hosts

### Framework Laptop (`framework`)
- **Hardware**: Framework 12th gen Intel laptop
- **Optimizations**: Battery management, thermal controls, power efficiency
- **Graphics**: Intel integrated graphics with hardware acceleration
- **Features**: Fingerprint reader, TLP power management, auto-cpufreq

### Desktop (`desktop`)
- **Hardware**: Desktop with NVIDIA GPU
- **Optimizations**: High performance, gaming-focused
- **Graphics**: NVIDIA GPU with proprietary drivers
- **Features**: Steam, gamemode, virtualization, audio production tools

## Building

### Framework Laptop
```bash
sudo nixos-rebuild switch --flake .#framework
```

### Desktop
```bash
sudo nixos-rebuild switch --flake .#desktop
```

## Directory Structure

```
├── flake.nix                    # Main flake configuration
├── hosts/
│   ├── framework/               # Framework laptop configuration
│   │   └── default.nix
│   └── desktop/                 # Desktop configuration
│       └── default.nix
├── modules/
│   ├── boot.nix                 # Boot configuration
│   ├── desktop.nix              # Cosmic desktop environment
│   ├── networking.nix           # Network configuration
│   ├── system.nix               # System-wide configuration
│   ├── framework.nix            # Framework-specific optimizations
│   ├── nvidia.nix               # NVIDIA GPU configuration
│   └── desktop-hardware.nix     # Desktop hardware optimizations
├── users/
│   └── daimyo/                  # User configuration
└── hardware-configuration.nix   # Hardware-specific configuration
```

## Key Features

### Framework Configuration
- TLP for battery optimization
- Auto-cpufreq for intelligent CPU scaling
- Fingerprint authentication support
- Intel graphics with hardware acceleration
- Thermal management
- Power management for AC/battery usage

### Desktop Configuration
- NVIDIA GPU with proprietary drivers
- Gaming optimizations (Steam, Gamemode)
- High-performance CPU governor
- Audio production tools (JACK, PipeWire)
- Virtualization support (KVM, libvirt)
- Hardware monitoring tools

## Getting Started

### Prerequisites
- NixOS installed
- Nix flakes and the experimental features enabled

### Clone the Repository
```bash
git clone https://github.com/your-username/your-repository.git /etc/nixos
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

Each host configuration can be customized by modifying the respective files in the `hosts/` directory. Common modules are shared between configurations, while host-specific modules provide specialized functionality.

- **Add New Hosts**: Create a new directory under `hosts/` and add it to `flake.nix`
- **Add New Users**: Create a new directory under `users/` and import it in the host configuration
- **Modify System Settings**: Edit the appropriate module in `modules/`
- **Customize User Environment**: Edit `users/daimyo/home.nix`

## Notes

- Both configurations use the Cosmic desktop environment
- Home Manager is integrated for user-specific configurations
- All configurations support Flatpak for additional software
- The framework configuration includes nixos-hardware modules for optimal hardware support
