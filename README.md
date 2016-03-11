# Galaxie

Ansible toolbox aimed at managing a set of Debian servers.

## Bootstrap

* define the variable `galaxie_user` either in your `./hosts` of group_vars. Does not mater where, but have it defined when launching intergation playbook.
* Add you host and all its connection vars to your `./hosts` file in the `[galaxie_staging]` group
* run `ansible-playbook playbooks/server_bootstrap.yml`

That will give you:

* `galaxie_user` access to host
* a key in `./keys` for this host
* a file in `./secrets` with galaxie user password
* a file in `./host_vars_` with correct connection options for this hosts

After this you can move you host out of the `[galaxie_staging]` group.