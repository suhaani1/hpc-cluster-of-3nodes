# Munge

Munge provides authenticated credentials for services such as Slurm.

## Verify

```bash
systemctl status munge
munge -n | unmunge
```

A successful test should report a successful status.

## Important

Every Slurm node must use the same Munge key.

Do not place the key in this Git repository.

Typical sensitive file:

```text
/etc/munge/munge.key
```

Protect it with the permissions required by the installed Munge package.
