[Galaxie-Clans Documentation](README.md) / [How-to Guides](_HOWTO__.md)

# How to integrate a new server?

## Ready?

You need:
* a Debian 10 server with ssh access and `su` or `sudo` privilege

## Set.

Bear in mind that we use:
* `new_server` as the hostname
* `$NEW_SERVER_IPV4` as the host ipv4 public address

> As you go on the copy-paste way, __replace__ these occurences with meaningful values for your case.


## Go!

### Local configuration

* __Generate a key for your host__

Run:
```
ssh-keygen -t ed25519 -f ./keys/new_server.key -C "caretaker@new_server" -N ""
```

* __Configure SSH client__

Add a block to your `ssh.cfg`:
```
Host new_server
    Hostname $NEW_SERVER_IPV4
    User caretaker
    IdentityFile ./keys/new_server.key
    IdentitiesOnly yes
```

* __Update ansible inventory__

You should have:
* a group named `clans` with `new_server` as a member

At the simplest, add this to the `hosts` file:
```
[clans]
new_server
```

> Congratulations! You now have local configuration ready to perform `galaxie-clans` installation!

### Install `caretaker` user access

We have setup local configuration as expected, now we need to override these sweet connection options to match
reality of your unprepared server. The base commande to run is:
```
ansible-playbook playbooks/clan_caretaker_install.yml -e scope=new_server $EXTRA_CONNECTION_OPTIONS
```

> This $EXTRA_CONNECTION_OPTIONS is to be replaced by your specific (and unique) case!
> 
> You can pick in these:
> * `-e ansible_ssh_user=your_default_user` to set a specific connection user
> * `-k` to have ansible prompt for SSH password
> * `-K` to have ansible prompt for become method password
> * `--become` to elevate privileges after connection
> * `--become-method=su` to rely on `su` instead of `sudo` for privilege escalation

### Validate access

```
ansible -m ping new_server --become
```

It should give you a __glorious__:
```
new_server | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

## EOC