# Galaxie

### Migration plan
* Fork bests existing Ansible, convert it to support Debian stable.
* Migrate our config files to YAML format
* Limit the number of Galaxie roles to maintain

#### Criterias

* Each projects selected must have strong and active maintainer community
* Roles should be highly customizable by variables
* The design must permit easy upgrade

### Why this migration?

Unfortunately for us, DJB Tools like ``dnscache``, ``tinydns``, ``qmail``, ``damontools`` are dead without true IPV6, DNSSEC support.
The original author haven't gathered a community of maintainers, nor kept upgrading its softwares for a long time.
Free software is only as good as its community...

We choose to erase that part of you life and try to be serious. It was a mirage, nothing was true.
We don't have much time to spend on earth... We have no time to loose on that lost dream anymore.

With this migration we'll trash a ton of work, and that's why we start from a big fork of [Bert Van Vreckem](https://github.com/bertvv) ansible roles,
with goal to back to Galaxie way one day.

#### Critical - Galaxie Core

* **NTP**: ``ntp`` -
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

Look like it's not that important, but that really matters for family members.

* **TELEPHONY**: ``asterisk``
* **SHARE**: ``samba`` - https://github.com/bertvv/ansible-role-samba
* **RPITVOS**: ``Libreelec`` -
* **MEDIASERVER**: ``Jellyfin`` -
* **PVR**: ``TVHeadend`` -
* **FIREWALL** ``OPNSense`` -
* **VPN** ``OPNSense`` -

Once upon a time, this project was hosted on a ancient platform called GitHub. Then came the Buyer.
The Buyer bought GitHub, willing to rule over its community. We were not to sell, so here is the new home of "https://github.com/Tuuux/galaxie".


Ansible toolbox aimed at managing a set of Debian servers. Originaly written for managing a Home Network with external services.

That is a set of powerfull roles made by a senior system admin and reviewed by a senior developer.

Galaxie is a true mix of the two world, by luck author Tuux and Mo have made the necessary to have no compromise.

Do you know a lot of Ansible roles which verify your DHCP client settings after having touched your /etc/resolv.conf ?

- Pure System Admin compliance
- Pure Syntax Devs compliance

It will be an honor if you take our work as an example, our roles are correct from a sysadmin point of view.

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

## Bootstrap - DEPRECATED

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


# Notes

* terminal d'admin opérable depuis une clé live Tails
avec les clés d'accès vers l'instance qui porte
* session de génération de clé sur un host deconnecté du reseau depuis une live usb tail
prereq: host avec 2 port usb un pour demarrer tail l'autre pour récupérer se clé perso

etablir un lien passe par une clé rsa de connexion sur une home avec un minimum de droits, contenant directement
les variables et un trigger ssh

prereq: exposition d'un enregistrement clan.<domain> sur la zone DNS publique
 pointe vers un host qui expose le port SSH d'admin

## Making a clan alliance

* New ally clan gives you a public ssh key.
* Put it under `keys/<YOUR_CLAN_NAME>/allies/<THEIR_CLAN_NAME>.pub`
* Add THEIR_CLAN_NAME to the host inventory under the group `[<YOU_CLAN_NAME>_allies]`
* Run `ansible-playbook playbooks/clan-establish.yml`

Now they can connect via ssh to get the minimal infos to configure themselves as your secondary on several services.

## TODO

* playbook pour initier un nouveau clan et preparer les repertoire, generer les keys,
* les fichier de group vars : guide pour savoir où surcharger 'clan_allies_export' (à savoir dans le fichier de group_var du clan qui exporte

# Ansible coding guidelines