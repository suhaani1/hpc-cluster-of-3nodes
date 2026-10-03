# Networking

The three nodes must be able to communicate over the cluster network.

Example:

```text
headnode  192.168.109.141
cn1       192.168.109.142
cn2       192.168.109.143
```

Check interfaces:

```bash
ip addr
ip route
nmcli device status
```

Check reachability:

```bash
ping -c 3 cn1
ping -c 3 cn2
```

Check SSH:

```bash
ssh admin123@cn1 hostname
ssh admin123@cn2 hostname
```

For VirtualBox, choose a networking mode that gives all three VMs connectivity to one another. A host-only network is useful for an isolated lab; NAT can be used for internet access, but its addressing and inbound connectivity need to be configured appropriately.
