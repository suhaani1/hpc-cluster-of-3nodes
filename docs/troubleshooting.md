# Troubleshooting

## SSH connection refused

Check:

```bash
systemctl status sshd
ss -lntp | grep :22
ip addr
ping cn1
```

## Hostname does not resolve

Check:

```bash
getent hosts cn1
getent hosts cn2
```

Review `/etc/hosts` or your DNS configuration.

## `/shared` is not mounted

On client:

```bash
mount | grep /shared
showmount -e headnode
```

On server:

```bash
sudo exportfs -v
systemctl status nfs-server
```

## Munge test fails

Check:

```bash
systemctl status munge
journalctl -u munge
ls -l /etc/munge/munge.key
```

Make sure every Slurm node has the same key.

## `sinfo` shows no nodes

Check:

```bash
systemctl status slurmctld
systemctl status slurmd
scontrol show nodes
journalctl -u slurmctld
journalctl -u slurmd
```

Check that the names in `slurm.conf` exactly match the hostnames.

## MPI executable not found

Check every node:

```bash
which mpirun
which mpicxx
which orted
```

Use the same MPI implementation/version across the cluster where practical.

## MPI works on one node but not multiple nodes

Check:

- SSH connectivity
- hostname resolution
- firewall rules
- MPI installation on compute nodes
- executable availability on compute nodes
- MPI launcher configuration

## Permission denied in `/shared`

Check:

```bash
ls -ld /shared
ls -l /shared
id
```

For an educational cluster, use a deliberate ownership/group model rather than repeatedly applying `chmod 777`.
