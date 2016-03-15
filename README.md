# Galaxie

Ansible toolbox aimed at managing a set of Debian's like servers. Originaly write for manage Home Network with external services.
That a Serie a powerfull Roles make by a senior system admin and review by a senior develloper.
Galaxie is a true mixe of the two world, by luck author Tuux and Mo have make the necessary for have no compromise.

Do you know lot of roles it verify you DHCP client setting after have touch you /etc/resolv.conf ?

- Pure System Admin compliance
- Pure Syntax Devs compliance

It will be a honnnor if you take as exemple our work, our roles are correct if regarding system admin point of view, that unfortunally not the case for many Ansible Roles. 
All our Work is published under GPL 2 or Later version
The Galaxie system is use as Action Layer for a AI call Alferd: 
* https://github.com/aurelienmaury/alfred
* https://github.com/aurelienmaury/alfred-brain
* https://github.com/aurelienmaury/alfred-spine
* https://github.com/aurelienmaury/alfred-muscles (Galaxie is use here)
* https://github.com/aurelienmaury/alfred-cli

## How the Magic happen
Galaxie is provide a subdirectory

>./galaxie
>├── ansible.cfg    (Config file for ansible setting)
>├── hosts          (Config file for ansible inventory file)
>├── group_vars     (Ansible Group Vars directory, The groupe.yml file can store dedicated group of host vars)
>├── host_vars      (Ansible Host Vars directory, The hostname.yml file can store dedicated host vars)
>├── keys           (Directory where is generate and store SSH private and pub keys)
>├── playbooks      (Directory where Ansys Playbooks are store)
>├── roles          (Directory where Ansys Roles are store)
>├── secrets        (Directory where is store password)
>└── zone_files     (Directory where is store primary and secondary DNS zone files)


## Bootstrap

We use a bootstrap playbook for new host addition

* define the variable `galaxie_user` either in your `./hosts` of group_vars. Does not mater where, but have it defined when launching intergation playbook.
* Add you host and all its connection vars to your `./hosts` file in the `[galaxie_staging]` group
* run `ansible-playbook playbooks/server_bootstrap.yml`

That will give you:

* `galaxie_user` access to host
* a key in `./keys` for this host
* a file in `./secrets` with galaxie user password
* a file in `./host_vars_` with correct connection options for this hosts

After this you can move you host out of the `[galaxie_staging]` group.