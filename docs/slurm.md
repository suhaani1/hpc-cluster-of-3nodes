# Slurm

Slurm manages compute resources and schedules jobs.

## Main commands

```bash
sinfo
squeue
scontrol show nodes
sbatch slurm/test-job.sh
srun hostname
scancel JOB_ID
```

## Components

```text
slurmctld
    |
    +---- slurmd on cn1
    |
    +---- slurmd on cn2
```

## Basic workflow

```text
Write job script
      |
      v
    sbatch
      |
      v
  Slurm queue
      |
      v
  Compute nodes
      |
      v
     Job
```

## Troubleshooting states

A node shown as `DOWN`, `DRAIN`, or `UNKNOWN` requires checking both Slurm configuration and the compute-node daemon.

Useful commands:

```bash
sinfo -N -l
scontrol show node cn1
scontrol show node cn2
systemctl status slurmctld
systemctl status slurmd
journalctl -u slurmctld
journalctl -u slurmd
```

Do not blindly force nodes into `IDLE`; first find the underlying configuration or daemon problem.
