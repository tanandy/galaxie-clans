[Galaxie-Clans Documentation](README.md) / [Tutorials](_TUTO__.md)

# Tutorial: Found a galaxie-clan on a Kimsufi server

This tutorial will guide you through installing a fresh clan instance on a Kimsufi server, from zero to
all services enabled.

## Starting line

* Have a ready `galaxie-clans` workspace (see [How to setup a galaxie-clans workspace](_howto_setup.md))
* Have a Kimsufi Server
* Install it with the template `Debian 9 (Stretch) (64bits)`
* Validate you can login as root with the newly generated password

## Assumptions

* We will call our host `kimserver`. If you want to rename it, be aware to replace any occurence in the steps.
* We will use 2 labels that you will have to replace with actual values: `KIM_IPV4` and `KIM_IPV6`.
* All commands are to be run from the root of your local clone of `galaxie-clans` project.

## Steps

### Add `kimserver` to managed servers

* __Generate a key for later connections__

From your `galaxie-clans` workspace, run:
```
$ ssh-keygen -t ed25519 -f ./keys/kimserver.key -C "caretaker@kimserver" -N ""
```

* __Configure SSH client__

Add a block to your `ssh.cfg`:
```
Host kimserver
    Hostname KIM_IPV4
    User caretaker
    IdentityFile ./keys/kimserver.key
    IdentitiesOnly yes
```

* __Add `kimserver` to Ansible inventory__

You should have `kimserver` as a member of the `clans` group.
```
[clans]
kimserver
```

> Congratulations! You now have your server at hand to perform `galaxie-clans` installation.

### Upgrade to Debian Buster

* From your `galaxie-clans` workspace, run:
```
ansible-playbook playbooks/debian-upgrade-version.yml -e scope=kimserver -e ansible_ssh_user=root
```

* Connect to `kimserver` as root and reboot it:
```
$ ssh -F ssh.cfg kimserver -l root
[...]
root@ns3000003:~# reboot
```

### 