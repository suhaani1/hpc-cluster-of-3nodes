#!/usr/bin/env bash
set -euo pipefail

echo "Head-node base setup"

sudo systemctl enable --now sshd
sudo mkdir -p /shared
sudo chmod 755 /shared

echo
echo "Head node prepared."
echo "Next: configure NFS server, MPI, Munge, and Slurm controller."
