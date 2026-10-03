#!/usr/bin/env bash
set -euo pipefail

SHARED_DIR="${SHARED_DIR:-/shared}"
NETWORK="${CLUSTER_NETWORK:-192.168.109.0/24}"

sudo dnf install -y nfs-utils
sudo mkdir -p "$SHARED_DIR"
sudo chmod 755 "$SHARED_DIR"

EXPORT_LINE="$SHARED_DIR $NETWORK(rw,sync,no_subtree_check)"

if ! grep -Fxq "$EXPORT_LINE" /etc/exports; then
    echo "$EXPORT_LINE" | sudo tee -a /etc/exports
fi

sudo exportfs -rav
sudo systemctl enable --now nfs-server

echo "NFS server configured for $NETWORK"
sudo exportfs -v
