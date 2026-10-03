# Testing

## Layer 1: network

```bash
ping -c 3 cn1
ping -c 3 cn2
```

## Layer 2: SSH

```bash
ssh cn1 hostname
ssh cn2 hostname
```

## Layer 3: shared storage

```bash
df -h /shared
touch /shared/test-from-headnode
```

From cn1/cn2:

```bash
ls -l /shared/test-from-headnode
```

## Layer 4: Munge

```bash
munge -n | unmunge
```

## Layer 5: Slurm

```bash
sinfo
squeue
sbatch slurm/test-job.sh
```

## Layer 6: MPI

```bash
cd mpi
make
mpirun -np 4 ./hello_mpi
```

## Layer 7: MPI + Slurm

```bash
sbatch slurm/mpi-job.sh
```

## Layer 8: Hybrid MPI + OpenMP

```bash
sbatch slurm/hybrid-job.sh
```
