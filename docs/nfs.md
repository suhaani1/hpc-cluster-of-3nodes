# NFS Shared Storage

NFS gives the cluster a common filesystem.

## Server

The headnode exports:

```text
/shared
```

Example `/etc/exports`:

```text
/shared 192.168.109.0/24(rw,sync,no_subtree_check)
```

Apply:

```bash
sudo exportfs -rav
sudo systemctl enable --now nfs-server
```

## Clients

On cn1/cn2:

```bash
sudo mkdir -p /shared
sudo mount headnode:/shared /shared
```

Verify:

```bash
df -h /shared
mount | grep /shared
```

## Persistent mount

Use `/etc/fstab` only after testing the manual mount.

Example:

```text
headnode:/shared /shared nfs defaults,_netdev 0 0
```
