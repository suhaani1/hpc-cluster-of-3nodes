# HPC Cluster Project

A three-node High Performance Computing (HPC) cluster built with Rocky Linux and Oracle VirtualBox.

## Architecture

| Node | Role | Example IP |
|---|---|---|
| HEADNODE | Controller / login / shared-storage server | `192.168.109.141` |
| CN1 | Compute node 1 | `192.168.109.142` |
| CN2 | Compute node 2 | `192.168.109.143` |

> The IP addresses above describe the lab topology used during development. Change them to your own values before reusing the configuration.

```text
                         HPC CLUSTER
                              |
                    +---------+---------+
                    |                   |
              +-----v------+      +-----v------+
              | HEADNODE   |      | Shared NFS |
              | Controller |      | /shared    |
              +-----+------+      +------------+
                    |
              +-----+-----+
              |           |
        +-----v-----+ +---v-------+
        |    CN1    | |    CN2    |
        | Compute 1 | | Compute 2 |
        +-----------+ +-----------+
```

## Components

- Rocky Linux 9
- Oracle VirtualBox
- SSH
- NFS shared storage
- Open MPI
- Munge authentication
- Slurm workload manager
- C/C++ MPI test programs
- Slurm batch jobs

## Repository structure

```text
hpc-cluster-project/
├── README.md
├── .gitignore
├── LICENSE
├── docs/
│   ├── architecture.md
│   ├── installation.md
│   ├── networking.md
│   ├── ssh.md
│   ├── nfs.md
│   ├── mpi.md
│   ├── munge.md
│   ├── slurm.md
│   ├── testing.md
│   └── troubleshooting.md
├── scripts/
│   ├── setup-common.sh
│   ├── setup-headnode.sh
│   ├── setup-compute-node.sh
│   ├── configure-nfs-server.sh
│   ├── configure-nfs-client.sh
│   ├── verify-cluster.sh
│   └── verify-mpi.sh
├── config/
│   ├── hosts.example
│   └── slurm.conf.example
├── mpi/
│   ├── hello_mpi.cpp
│   ├── pi_mpi.cpp
│   ├── hybrid_sum.cpp
│   └── Makefile
├── slurm/
│   ├── test-job.sh
│   ├── mpi-job.sh
│   └── hybrid-job.sh
└── docs/screenshots/
```

## 1. Prerequisites

Each VM should have:

- Rocky Linux 9.x
- A static or reserved IP address
- Hostname configured
- Working DNS or `/etc/hosts`
- A common user such as `admin123`
- Network connectivity between all nodes
- Sudo access

Recommended minimum for a lab:

- 2 CPU cores per VM
- 2–4 GB RAM per VM
- 20 GB disk per VM

## 2. Hostnames

Use:

```bash
hostnamectl set-hostname headnode
hostnamectl set-hostname cn1
hostnamectl set-hostname cn2
```

On every node, maintain matching host entries. Start from:

```bash
sudo cp config/hosts.example /etc/hosts
```

Then edit the addresses for your environment.

## 3. SSH

From the head node:

```bash
ssh admin123@cn1
ssh admin123@cn2
```

For passwordless administration, create an SSH key on the head node and copy only the public key:

```bash
ssh-keygen -t ed25519
ssh-copy-id admin123@cn1
ssh-copy-id admin123@cn2
```

Never commit private keys.

## 4. NFS shared storage

The head node exports `/shared`. Compute nodes mount it.

Server:

```bash
sudo mkdir -p /shared
sudo chmod 755 /shared
sudo nano /etc/exports
```

Example export:

```text
/shared 192.168.109.0/24(rw,sync,no_subtree_check)
```

Apply:

```bash
sudo exportfs -rav
sudo systemctl enable --now nfs-server
```

Client:

```bash
sudo mkdir -p /shared
sudo mount headnode:/shared /shared
```

For persistent mounting, add the NFS entry to `/etc/fstab`.

## 5. MPI

Install the MPI implementation consistently on all nodes.

Verify:

```bash
which mpirun
mpirun --version
```

Compile:

```bash
cd mpi
make
```

Run a local test:

```bash
mpirun -np 4 ./hello_mpi
```

A multi-node run requires the MPI runtime to be available on every compute node and SSH/launcher configuration to be correct.

## 6. Munge

Munge provides authentication used by Slurm.

On the controller and every compute node:

```bash
sudo systemctl enable --now munge
sudo systemctl status munge
munge -n | unmunge
```

The same Munge key must be securely distributed to all Slurm nodes.

Do **not** commit `/etc/munge/munge.key` or any private credential to GitHub.

## 7. Slurm

Slurm consists of:

- `slurmctld` — controller daemon
- `slurmd` — compute-node daemon
- `sinfo` — partition/node status
- `squeue` — queued/running jobs
- `sbatch` — submit batch jobs
- `srun` — launch parallel tasks
- `scancel` — cancel jobs

After installing and configuring Slurm:

```bash
sinfo
scontrol show nodes
```

Expected logical layout:

```text
PARTITION  AVAIL  TIMELIMIT  NODES  STATE
compute*      up   ...            2   idle
```

The exact output depends on your `slurm.conf`.

## 8. Test a Slurm job

```bash
sbatch slurm/test-job.sh
squeue
```

Inspect the output file:

```bash
cat slurm-test-*.out
```

## 9. MPI through Slurm

Submit:

```bash
sbatch slurm/mpi-job.sh
```

Or launch interactively:

```bash
srun -N 2 -n 4 ./mpi/hello_mpi
```

Use the resource request appropriate for your cluster.

## 10. Hybrid MPI + OpenMP

The hybrid example uses:

```text
MPI ranks
   |
   +-- OpenMP threads inside each rank
   |
   +-- local reduction
   |
   +-- MPI_Allreduce
   |
Global result
```

Compile with:

```bash
mpicxx -O2 -fopenmp mpi/hybrid_sum.cpp -o mpi/hybrid_sum
```

## 11. Verification checklist

Run:

```bash
bash scripts/verify-cluster.sh
```

Then verify:

```bash
sinfo
squeue
munge -n | unmunge
df -h /shared
```

## 12. Security

This repository intentionally excludes:

- SSH private keys
- Munge keys
- passwords
- cloud credentials
- API tokens
- personal configuration files
- VM snapshots

Before publishing:

```bash
git status
git diff --cached
```

Search for accidental secrets before pushing.

## 13. Learning outcomes

This project demonstrates:

- Linux system administration
- Virtual machine networking
- SSH-based cluster administration
- Shared storage with NFS
- Distributed-memory programming with MPI
- Authentication with Munge
- Resource management with Slurm
- Batch job submission
- MPI + OpenMP hybrid programming
- Basic HPC troubleshooting

## 14. Future improvements

Possible extensions:

- Prometheus/Grafana monitoring
- Ganglia or another HPC monitoring stack
- Automated provisioning with Ansible
- Containerized HPC workloads
- GPU compute node
- Benchmarking with HPL
- MPI performance comparison
- Automated CI checks for configuration examples

## Author

Built as an educational HPC cluster project using Rocky Linux.
