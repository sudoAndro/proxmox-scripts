# VirtioFS Setup - Proxmox Shared Storage

Anleitung um einen gemeinsamen Ordner vom Proxmox Host in VMs einzubinden.

## Was ist VirtioFS?

VirtioFS ermöglicht es einen Ordner vom Proxmox Host direkt in eine VM
einzubinden - ohne Netzwerk, ohne Samba. Schnell und einfach.

## Schritt 1 - Verzeichnis-Mapping erstellen (Web UI)

1. **Datacenter** → **Verzeichnis-Mappings** → **Hinzufügen**
2. ID: `Folder`
3. Knoten: `pve`
4. Pfad: `/mnt/share`
5. Kommentar: `gemeinsamer Ordner`
6. **Hinzufügen** klicken

## Schritt 2 - VirtioFS zu VM hinzufügen (Web UI)

1. VM auswählen
2. **Hardware** → **Hinzufügen** → **Virtiofs**
3. Verzeichnis ID: `Folder` auswählen
4. **Hinzufügen** klicken
5. VM **neu starten**

## Schritt 3 - In der VM einbinden (Debian/Kali)

```bash
# Mountpunkt erstellen
mkdir -p /mnt/share

# Einmalig mounten (zum testen)
mount -t virtiofs Folder /mnt/share

# Inhalt prüfen
ls /mnt/share
```

## Schritt 4 - Permanent einbinden (fstab)

```bash
nano /etc/fstab
```

Folgende Zeile hinzufügen:
- Folder /mnt/share virtiofs defaults 0 0

Testen ohne Neustart:

```bash
mount -a
ls /mnt/share
```

## Symlink im Home-Verzeichnis (optional)

```bash
ln -s /mnt/share ~/share
```

## Unterstützte VMs

| VM ID | Name | Status |
|-------|------|--------|
| 102 | Debian-GUI | ✅ |
| 103 | Debian-CLI | ✅ |
| 104 | Kali | ✅ |
| 106 | Ubuntu-GUI | ✅ |
| 107 | Ubuntu-CLI | ✅ |