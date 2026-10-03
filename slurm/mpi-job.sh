#!/usr/bin/env bash
#SBATCH --job-name=mpi-hello
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --time=00:05:00
#SBATCH --output=mpi-job-%j.out

set -euo pipefail

ROOT="${SLURM_SUBMIT_DIR}"
make -C "$ROOT/mpi"

srun "$ROOT/mpi/hello_mpi"
