# Installation Guide

## 1. Create VMs

Create three Rocky Linux VMs:

- headnode
- cn1
- cn2

Use the same Rocky Linux major version across the cluster.

## 2. Set hostnames

Run the matching command on each VM:

```bash
sudo hostnamectl set-hostname headnode
sudo hostnamectl set-hostname cn1
sudo hostnamectl set-hostname cn2
```

## 3. Configure networking

Give each VM a reachable address on the same cluster network.

Test:

```bash
ping -c 3 cn1
ping -c 3 cn2
```

## 4. Run common setup

On each node:

```bash
bash scripts/setup-common.sh
```

## 5. Configure NFS

On headnode:

```bash
bash scripts/configure-nfs-server.sh
```

On cn1 and cn2:

```bash
bash scripts/configure-nfs-client.sh
```

## 6. Configure MPI

Install the same MPI implementation on every node. Then verify:

```bash
mpirun --version
mpicxx --version
```

## 7. Configure Munge

Install Munge on all Slurm nodes. Copy the same Munge key securely to every node and fix its ownership and permissions according to the installed package documentation.

Test:

```bash
munge -n | unmunge
```

## 8. Configure Slurm

Install the Slurm controller package on headnode and the compute daemon package on cn1/cn2.

Use `config/slurm.conf.example` as a starting point. Adjust:

- CPU counts
- state directories
- log paths
- node names
- partition names

Start:

```bash
sudo systemctl enable --now slurmctld
```

On compute nodes:

```bash
sudo systemctl enable --now slurmd
```

Then:

```bash
sinfo
scontrol show nodes
```

## 9. Test

```bash
sbatch slurm/test-job.sh
squeue
```
