#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Samba Setup Script für Proxmox Host
# Erstellt von sudoAndro
# ============================================================

SHARE_PATH="/mnt/share"
SHARE_NAME="ProxmoxShare"
SAMBA_USER="andrijan"

print_info() { echo -e "\e[1;34m[INFO]\e[0m $1"; }
print_ok()   { echo -e "\e[1;32m[ OK ]\e[0m $1"; }
print_err()  { echo -e "\e[1;31m[ERR ]\e[0m $1"; }

require_root() {
    if [[ "${EUID}" -ne 0 ]]; then
        print_err "Bitte als root oder mit sudo ausführen."
        exit 1
    fi
}

create_share_dir() {
    print_info "Erstelle Freigabe-Verzeichnis: $SHARE_PATH"
    mkdir -p "$SHARE_PATH"
    chmod 777 "$SHARE_PATH"
    print_ok "Verzeichnis erstellt."
}

install_samba() {
    print_info "Installiere Samba..."
    apt update
    apt install -y samba
    print_ok "Samba installiert."
}

configure_samba() {
    print_info "Konfiguriere Samba..."
    cat >> /etc/samba/smb.conf <<EOF

[$SHARE_NAME]
   path = $SHARE_PATH
   browseable = yes
   read only = no
   guest ok = no
   valid users = $SAMBA_USER
   create mask = 0755
EOF
    print_ok "Samba konfiguriert."
}

create_samba_user() {
    print_info "Erstelle System-User: $SAMBA_USER"
    if ! id "$SAMBA_USER" &>/dev/null; then
        useradd -M -s /sbin/nologin "$SAMBA_USER"
        print_ok "System-User erstellt."
    else
        print_ok "System-User existiert bereits."
    fi

    print_info "Samba-Passwort setzen für: $SAMBA_USER"
    smbpasswd -a "$SAMBA_USER"
}

restart_samba() {
    print_info "Starte Samba neu..."
    systemctl restart smbd
    systemctl enable smbd
    print_ok "Samba läuft."
}

main() {
    require_root
    create_share_dir
    install_samba
    configure_samba
    create_samba_user
    restart_samba

    echo
    print_ok "Samba Setup abgeschlossen!"
    echo
    echo "Verbinden von Windows:"
    echo "  \\\\$(hostname -I | awk '{print $1}')\\$SHARE_NAME"
}

main "$@"