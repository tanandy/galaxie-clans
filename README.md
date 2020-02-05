# Galaxie

### Migration plan
* Fork bests existing Ansible, convert it for support Debian and Alpine.
* Migrate ou config files to yaml format

#### Criteria
* Each projects choose should be really popular
* Roles should have a maximum of variables
* Roles should permit big setting via yaml files
* The design must permit easy upgrade
* Roles mono action

### Why it migration?
The winner is definitively **Bert Van Vreckem** where almost all the Galaxie core will be migrate to him ansible roles.
https://github.com/bertvv . Here we fork for our needs and save time, because we'll trash our preview DJBWay design.

Just a note about DJB Tools like ``dnscache``, ``tinydns``, ``qmail``, ``damontools``, The author haven't maintain a community, or keep upgrade any software from many time, the Free software if good when it have a community ...<BR><BR>
Forget that part of you life, it was a mirage, nothing was true. We haven't mush time on earth ... No way to lost our time on that lost dream anymore.<BR><BR>
With it migration we'll trash a tonne of work, and that is why we start from a big fork of **Bert Van Vreckem** ansible roles, with goal to back to Galaxie way one day.<BR>

#### Critical - Galaxie Core
* **NTP**: ``ntpd`` - Refresh our ?
* **DNS**: ``named`` - https://github.com/bertvv/ansible-role-bind
* **TFP**: ``tfpd`` - https://github.com/bertvv/ansible-role-tftp
* **PXE** ``pxelinux`` - https://github.com/bertvv/ansible-role-pxeserver
* **DHCP**: ``dpcpd`` - https://github.com/bertvv/ansible-role-dhcp
* **MAIL**: ``Postfix / Dovecot`` - https://github.com/bertvv/ansible-role-mailserver

#### Broadcasting - Galaxie Media
* **SQL**: ``mariadb`` - https://github.com/bertvv/ansible-role-mariadb
* **WEBSERVER** ``ngnx / lighthttpd / httpd`` - ?
* **MEETING**: ``jitsit``
* **WEBSITE**: ``peertube``

### Family - Galaxie Home
Look nothing but that really important for family members
* **TELEPHONY**: ``asterisk``
* **SHARE**: ``samba`` - https://github.com/bertvv/ansible-role-samba
* **RPITVOS**: ``Libreelec`` - 
* **MEDIASERVER**: ``Jellyfin`` - 
* **PVR**: ``TVHeadend`` - 
* **FIREWALL** ``OPNSense`` - 
* **VPN** ``OPNSense`` - 

Once upon a time, this project was hosted on a 
ancient platform called GitHub. Then came the Buyer.
The Buyer bought GitHub, willing to rule over its community.
I was not to sell, so here is the new home of "https://github.com/Tuuux/galaxie".


Ansible toolbox aimed at managing a set of Debian servers. Originaly written for managing a Home Network with external services.

That is a set of powerfull roles made by a senior system admin and reviewed by a senior developer.

Galaxie is a true mix of the two world, by luck author Tuux and Mo have made the necessary to have no compromise.

Do you know a lot of Ansible roles which verify your DHCP client settings after having touched your /etc/resolv.conf ?

- Pure System Admin compliance
- Pure Syntax Devs compliance

It will be an honnor if you take our work as an example, our roles are correct if regarding system admin point of view, that unfortunally not the case for many Ansible Roles.

All our Work is published under GPLv3.

The Galaxie system is also used as an Action Layer for an AI called Alfred: 

* https://github.com/aurelienmaury/alfred
* https://github.com/aurelienmaury/alfred-brain
* https://github.com/aurelienmaury/alfred-spine
* https://github.com/aurelienmaury/alfred-muscles (Galaxie is used here)
* https://github.com/aurelienmaury/alfred-cli

## How the Magic happen

```
./galaxie
├── ansible.cfg    (Config file for ansible setting)
├── hosts          (Config file for ansible inventory file)
├── group_vars     (Ansible Group Vars directory, The groupe.yml file can store dedicated group of host vars)
├── host_vars      (Ansible Host Vars directory, The hostname.yml file can store dedicated host vars)
├── keys           (Directory where is generate and store SSH private and pub keys)
├── playbooks      (Directory where Ansible Playbooks are store)
├── roles          (Directory where Ansible Roles are store)
├── secrets        (Directory where is store password)
└── zone_files     (Directory where is store primary and secondary DNS zone files)
```

## Bootstrap

We use a bootstrap playbook for new host addition.

* define the variable `galaxie_user` either in your `./hosts` or group_vars. Does not matter where, but have it defined when launching the integration playbook.
* Add you host and all its connection vars to your `./hosts` file in the `[galaxie_staging]` group
* run `ansible-playbook playbooks/server_bootstrap.yml`

That will give you:

* `galaxie_user` access to host
* a key in `./keys` for this host
* a file in `./secrets` with galaxie user password
* a file in `./host_vars_` with correct connection options for this hosts

After this you can move your host out of the `[galaxie_staging]` group and put it in its right place in your inventory and start hacking around with it.


