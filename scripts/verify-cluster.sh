#!/usr/bin/env bash
set -u

echo "===== HOST ====="
hostnamectl --static || hostname

echo
echo "===== IP ====="
hostname -I

echo
echo "===== HOST RESOLUTION ====="
getent hosts headnode cn1 cn2 || true

echo
echo "===== SSH ====="
for node in headnode cn1 cn2; do
    printf "%-10s " "$node"
    if timeout 5 bash -c "</dev/tcp/$node/22" 2>/dev/null; then
        echo "SSH port reachable"
    else
        echo "SSH port NOT reachable"
    fi
done

echo
echo "===== NFS ====="
df -h /shared 2>/dev/null || echo "/shared is not mounted"

echo
echo "===== MPI ====="
command -v mpirun || true
mpirun --version 2>/dev/null | head -n 1 || true

echo
echo "===== MUNGE ====="
command -v munge || true
if command -v munge >/dev/null 2>&1 && command -v unmunge >/dev/null 2>&1; then
    munge -n | unmunge | grep -E 'STATUS|ENCODE_HOST|DECODED' || true
fi

echo
echo "===== SLURM ====="
command -v sinfo || true
if command -v sinfo >/dev/null 2>&1; then
    sinfo || true
fi
