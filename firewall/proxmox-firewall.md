# Proxmox Firewall Konfiguration

Dokumentation der Firewall-Regeln für den Proxmox Host.

## Cluster Firewall (`/etc/pve/firewall/cluster.fw`)

```ini
[OPTIONS]
policy_in: DROP
enable: 1

[RULES]
GROUP samba
IN ACCEPT -source 192.168.50.0/24 -p tcp -dport 445 -log nolog
IN ACCEPT -source 192.168.50.0/24 -p tcp -dport 139 -log nolog
IN ACCEPT -source 192.168.50.0/24 -p tcp -dport 9999 -log nolog
IN ACCEPT -i vmbr0 -source 192.168.50.0/24 -p tcp -dport 8006 -log nolog
IN DROP -log nolog

[group samba]
IN ACCEPT -source 192.168.50.0/24 -p tcp -dport 139 -log nolog
IN ACCEPT -source 192.168.50.0/24 -p tcp -dport 445 -log nolog
```

## Wichtige Ports

| Port | Dienst | Beschreibung |
|------|--------|--------------|
| 8006 | Proxmox Web UI | HTTPS Management Interface |
| 9999 | SSH | Custom SSH Port |
| 445  | Samba | SMB Dateifreigabe |
| 139  | Samba | NetBIOS |

## Hinweise

- Policy ist `DROP` – alles was nicht explizit erlaubt ist wird geblockt
- Nur Zugriff aus dem lokalen Netz `192.168.50.0/24`
- Samba Ports müssen in `[RULES]` UND in der Group stehen!