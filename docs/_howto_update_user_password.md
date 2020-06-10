[Galaxie-Clans Documentation](README.md) / [How-to Guides](_HOWTO__.md)

# How to update a user's password ?
---
## Ready?

You must have:
* a `galaxie-clans` managed host
* `system_users` role managing the user you want to update password for

## Set.

* `$INVENTORY_HOSTNAME` is the name of the target host
* `$UNAME` should match the `uname` of a user managed by `system_users` role

## Go!

* __Get password hash__

The user must, on his side, use this command to hash the password he likes:
```
mkpasswd -m SHA-512
```
...and give it to the clan caretaker. 

> Until the end, this user-supplied hash value will be referenced as `$UHASH`.

* __Store password hash__

Run:
```
ansible-playbook playbooks/ops_store_user_hash.yml \
    -e scope=$INVENTORY_HOSTNAME \
    -e uname=$UNAME \
    -e uhash='$UHASH'
```

>
> Beware of the single quotes around `$UHASH`.
>

* __Spread password hash value__

Run:
```
ansible-playbook playbooks/setup_core_services.yml -e scope=$INVENTORY_HOSTNAME
```

If the clan host has some of broadcast services enabled, also run:
```
ansible-playbook playbooks/setup_broadcast_services.yml -e scope=$INVENTORY_HOSTNAME 
```

#### DONE