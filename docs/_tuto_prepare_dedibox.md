[Galaxie-Clans Documentation](README.md) / [Tutorials](_TUTO__.md)

# Prepare a Scaleway Dedibox server for installation

This will guide through specific technical steps to prepare a
[Dedibox server](https://www.scaleway.com/fr/dedibox/)
to be managed by galaxie-clans.

> This tutorial might become obsolete if Scaleway updates its Dedibox provisionning
> process. If so, please report.

## Ready?

You need:
* A dedibox server freshly installed with Debian 10 (Buster)
* The initial user name
* The initial user password
* The root password
* Its IPv4 address
* An access to [Online web console](https://console.online.net/)

## Set.

In this tutorial we will use:

* `dedibox` as the hostname of the server
* `USERNAME` as the initial user name
* `USERPWD` as the initial user password
* `ROOTPWD` as root password
* `DEDIBOX_IPV4` as the server's IPv4 public address

Adapt these to your taste.

## Go!

### Create an IPv6 block subnet 

* Follow [this documentation section](https://documentation.online.net/en/dedicated-server/network/ipv6/split-subnet) to order your IPv6 `/48` block
* Create one subnet for your server
* Save the `IP block`, prefix length and `DUID` values of your subnet for later. (We will reference these values as `IP_BLOCK`, `PREFIXLEN` and `DUID` from now on)

### Add server to ansible inventory

In your galaxie-clans workspace:
* Create a directory `host_vars/dedibox`
* Create a file `host_vars/dedibox/all.yml` with the following content (replace with your values):

```
---
dedibox_ipv6_address: "IP_BLOCK"
dedibox_ipv6_prefixlen: "PREFIXLEN"
dedibox_ipv6_duid: "DUID"
```

* Add a ssh configuration in your `ssh.cfg` file:

```
Host dedibox
  Hostname DEDIBOX_IPV4
  User USERNAME
  IdentitiesOnly yes
```

* Add server to ansible inventory (default in `$WORKSPACE/hosts`)
```
dedibox
```

* Validate ansible connectivity

```
ansible -m ping dedibox -k -K -b --become-method=su
```

### Enable IPv6 on default interface

* Run:
```
ansible-playbook playbooks/setup_ipv6_on_dedibox.yml -k -K -b --become-method=su -e scope=dedibox
```

## EOC