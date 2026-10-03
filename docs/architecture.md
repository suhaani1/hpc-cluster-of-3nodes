# Cluster Architecture

The lab uses three Rocky Linux virtual machines.

## Roles

### HEADNODE

The head node is used for:

- administration
- SSH access
- NFS server
- Slurm controller (`slurmctld`)
- job submission
- compiling shared applications

### CN1 and CN2

Compute nodes are used for:

- executing MPI processes
- executing Slurm jobs
- providing compute resources to users

## Data flow

```text
User
 |
 | SSH / sbatch
 v
HEADNODE
 |
 +---- Slurm ----> CN1
 |
 +---- Slurm ----> CN2
 |
 +---- NFS ------> /shared
```

The controller schedules work; it should not be confused with the compute workers.
