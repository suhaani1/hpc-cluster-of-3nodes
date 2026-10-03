#!/usr/bin/env bash
set -euo pipefail

echo "Updating package metadata..."
sudo dnf makecache

echo "Installing common cluster utilities..."
sudo dnf install -y \
    openssh-clients \
    openssh-server \
    nfs-utils \
    chrony \
    gcc \
    gcc-c++ \
    make \
    wget \
    curl

echo "Enabling time synchronization..."
sudo systemctl enable --now chronyd

echo "Common setup completed."
