#!/usr/bin/env bash
#SBATCH --job-name=hybrid-sum
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=2
#SBATCH --time=00:05:00
#SBATCH --output=hybrid-job-%j.out

set -euo pipefail

export OMP_NUM_THREADS="${SLURM_CPUS_PER_TASK}"

ROOT="${SLURM_SUBMIT_DIR}"
make -C "$ROOT/mpi"

srun "$ROOT/mpi/hybrid_sum"
