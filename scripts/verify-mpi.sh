#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v mpicxx >/dev/null 2>&1; then
    echo "mpicxx not found."
    exit 1
fi

make -C "$ROOT/mpi"

echo
echo "Running MPI hello test..."
mpirun -np 4 "$ROOT/mpi/hello_mpi"
