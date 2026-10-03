#!/usr/bin/env bash
set -euo pipefail

echo "Compute-node base setup"

sudo systemctl enable --now sshd
sudo mkdir -p /shared

echo
echo "Compute node prepared."
echo "Next: configure NFS client, MPI, Munge, and slurmd."
