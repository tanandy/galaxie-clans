[Galaxie-Clans Documentation](README.md) / [Tutorials](_TUTO__.md)

# Tutorial: Found a Galaxie Clan on a Kimsufi server

This tutorial will guide you through installing a fresh clan instance on a Kimsufi server, from zero to
all services enabled. 

> This is no marketing bullshit intending to push you into renting a Kimsufi server.
>
> This is only based on our available infrastructure at the time of writing.

## Starting line

* Have a ready `galaxie-clans` workspace (see [How to setup a galaxie-clans workspace](_howto_setup.md)).
* Have a [Kimsufi](https://www.kimsufi.com/) server, installed with the template `Debian 9 (Stretch) (64bits)`.
* Validate you are able to log as `root`.
* Configure a DNS to delegate a SOA to your server.

## Assumptions

* We will call our host `kimserver`. If you want to rename it, be aware to replace any occurence in the following steps.
* We will use 2 labels that you will have to replace with actual values: `KIM_IPV4` and `KIM_IPV6`.
* The domain that `kimserver` is SOA for will be named `tuto.galaxie.clans`. Replace any occurence in the following steps with the domain you chose.
* All commands are to be run from the root of your `galaxie-clans` workspace.

## Step 1: Integrate your server into `galaxie-clans` standards

### Add `kimserver` to managed servers

* __Generate a key for later connections__

Run:
```
ssh-keygen -t ed25519 -f ./keys/kimserver.key -C "caretaker@kimserver" -N ""
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

* __Update ansible inventory__

You should have `kimserver` as a member of the `clans` group. 

Add this to the `hosts` file:
```
[clans]
kimserver
```

> Congratulations! You now have your server at hand to perform `galaxie-clans` installation!

### Upgrade to Debian Buster

* __Perform in-place upgrade__
```
ansible-playbook playbooks/debian-upgrade-version.yml -e scope=kimserver -e ansible_ssh_user=root -k
```

* __Reboot the server__
```
ssh -F ssh.cfg kimserver -l root
[...]
root:~# reboot
```

### Install `caretaker` user access

* __Create `kimserver`'s host variables files__
```
mkdir host_vars/kimserver
echo '---' > host_vars/kimserver/main.yml
```

* __Configure `caretaker`'s first authorized key__
Edit `host_vars/kimserver/main.yml` file. Add:
```
caretaker_authorized_key_files:
  - "{{ (playbook_dir + '/../keys/kimserver.key.pub') | realpath }}"
```

* __Install `caretaker` user__

Run:
```
ansible-playbook playbooks/clan_caretaker_install.yml -e scope=kimserver -e ansible_ssh_user=root -k
```

* __Validate access__

Run:
```
ansible -m ping kimserver
```

It should give you a __glorious__:
```
kimserver | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

>
> Congratulations! You now have a normalized `caretaker` access to ease management of your server by ansible!
>

## Step 2: Configure services

### Configure delegated NS domain

### Configure services

## Step 3: Deploy services

## Step 4: Enjoy

> Your clan is founded!
>
> Welcome in the `galaxie-clans`'s community.
>
> From now on you can search [documentation](README.md) for other materials and go further in the rabbit hole.