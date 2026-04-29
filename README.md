# 🖥️ Proxmox Scripts

Scripts und Dokumentationen für mein Proxmox Homelab.

## 📁 Struktur

proxmox-scripts/
├── samba/
│   └── setup-samba.sh        # Samba Freigabe auf Proxmox Host
├── virtiofs/
│   └── setup-virtiofs.md     # VirtioFS Shared Storage Setup
├── firewall/
│   └── proxmox-firewall.md   # Firewall Regeln und Dokumentation
└── docs/
└── (weitere Dokumentation)

## Quick Start

### Samba Setup
```bash
curl -fsSL https://raw.githubusercontent.com/sudoAndro/proxmox-scripts/main/samba/setup-samba.sh | sudo bash
```

## Inhalt

### Samba
Erstellt eine Netzwerkfreigabe direkt auf dem Proxmox Host.
Erreichbar von Windows und allen VMs.

### VirtioFS
Bindet den gemeinsamen Ordner direkt in VMs ein.
Kein Netzwerk nötig - schnell und einfach.

### Firewall
Dokumentation der Proxmox Firewall Regeln.
Policy: DROP - nur explizit erlaubte Verbindungen.

## 🖧 Homelab Setup

| Komponente | Details |
|------------|---------|
| Hypervisor | Proxmox VE |
| Netzwerk | 192.168.50.0/24 |
| Shared Storage | /mnt/share |
| Windows Zugriff | \\\\proxmox-ip\\ProxmoxShare |

## 📝 Lizenz

MIT License - sudoAndro 2026