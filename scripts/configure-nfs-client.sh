#!/usr/bin/env bash
set -euo pipefail

SERVER="${NFS_SERVER:-headnode}"
REMOTE="${NFS_REMOTE:-/shared}"
MOUNTPOINT="${NFS_MOUNTPOINT:-/shared}"

sudo dnf install -y nfs-utils
sudo mkdir -p "$MOUNTPOINT"

if ! mountpoint -q "$MOUNTPOINT"; then
    sudo mount "${SERVER}:${REMOTE}" "$MOUNTPOINT"
fi

echo "NFS mount:"
df -h "$MOUNTPOINT"
