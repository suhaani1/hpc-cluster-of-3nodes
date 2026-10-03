# SSH Configuration

SSH is used for administration and, depending on MPI configuration, can also be used by MPI launchers.

## Test

```bash
ssh admin123@cn1
ssh admin123@cn2
```

## Passwordless SSH

On headnode:

```bash
ssh-keygen -t ed25519
ssh-copy-id admin123@cn1
ssh-copy-id admin123@cn2
```

Test:

```bash
ssh cn1 hostname
ssh cn2 hostname
```

## Security

Never publish:

```text
~/.ssh/id_ed25519
~/.ssh/id_rsa
```

Only public keys such as `*.pub` may be shared when appropriate.
