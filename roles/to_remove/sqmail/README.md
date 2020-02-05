s/qmail Role
============

sqmail role have goal to install and configure a s/qmail server from "fehcom" design.

    s/qmail (pronounced skew-mail) is a Mail Transfer Agent (MTA) based on Qmail
    suited for high-speed and confidential email transport over IPv4 and IPv6 networks.

For more informations: http://fehcom.de/sqmail/sqmail.html

That role by default don't follow exactelly the design describ by fehcom, it's very close but don't use Damontools by use Systemd and Rsyslog , path, values, file for have a dynamic setting. By exemple all UID, GID, path, can be change , or be different by machine (not sure it's usefull).

It role is part of Galaxie design, if you like it project please not fork that project like you go to the toilet, propose a patch or why not just send me a e-mail ?
I'm not part of "fehcom" team, i'm just a humain it focus on Galaxie design devellopement, you are free to use my work without any warranty , may be in 50 years that work will be out-dated who know ...

By default that role will done the same result as the "fehcom" documentation, that mean after all conditional test and teamplate application under Ansible all scripts, configuration files will use default as descript on "fehcom" documentation.
All the power/interest of that role is the capability to use "host_vars" or "group_vars" and custom every path or values, the configuration will stay automaticlly consistent.
Unfortunally that a feature it come with Ansible, then don't be usefull for "s/qmail" project, except the role it self ...

I do my best for workarround troubles without need to touch "s/qmail" source, actually "s/qmail have troubles it not permit easy automation.

my list of thins to repport to "fehcom" team:
- package/man error with qmail-local
- installation script ignore conf-svcdir value
- script .run don't take advantage of ucspi-tcp6 conf-tcpbin file
- 64 / 32 bit auto detection is aviable for s/qmail but put in hard value for ucspi-tcp6, may be auto for ucspi-ssl, and don't care about cdb
- (list not close)

That role try to fixe (by the hard way) or reduse the impact of they troubles

Requirements
------------
it should work on Debian's familly GNU/Linux distribution.
The role install it self requirements

The role NOT use the daemons-tool provide by Debian packages, uninstall outdated DEBIAN DJB packages like qmail(netqmail patch) , daemontools 

Features
--------
Like others Galaxie roles:
- That role use Ansible templating system for write files all is managable via variables store on "./defaults/main.yml" file
- It not depend of other strange Ansible modules, it try to be autonomus inside that role, Sources files are store on the role, it self.
- Respect a documented method, start here: http://www.fehcom.de/sqmail/sqmail.html
- Pure Systemd design, Not use Dameontools at all, that because that role use Ansible native service plugin/module.
- Pure Rsyslog design, use native /var/log/mail.log and /var/log/mail.XXX as require for mail system and big centralize logs services.

### Systemd:

- That role make the true systemd usage and a not fake thing it use Daemonttols on the background ... 
- For permit sslserver and ENV usage we use original script suppose to be start by daemontools. 

The magic happen with systemd type=forking when the exec command is finish by a "&", in that case systemd us $! and will know the forked PID. That really important to continue to use original s/qmail scripts that because SSL informations and ENV are use on the right way.

- A Other important thing is about the socket creation, we have to let sslserver creat the socket and bind IP to the network device that because s/qmail design use CDB file , it have no way to explain to systemd how deal with a CDB file.

https://github.com/Tuuux/galaxie/tree/master/roles/sqmail/templates/sqmail/service

- s/qmail scripts normaly prepare for Daemontools have recice a "&" at end of each file for permit to use Systemd type=forking.
- All scripts is store a s/qmail directory e. g. /var/qmail/bin with the same name as s/smail sources
- That role provide one .service file by service offer by s/qmail.

### Rsyslog

https://github.com/Tuuux/galaxie/blob/master/roles/sqmail/templates/etc/rsyslog.d/20-sqmail.conf.j2

- The role provide a template it follow path and name store on "./defaults/main.yml" file

### ucspi-tcp6:
- auto 32/64 bit configuration by x64 detection and switch play with -m64 on conf-ld files

### s/qmail:
- conf-log, get value from "glx_log_dir" defaults is /var/log
- scripts get all value from settings
- conf-ids, conf-group -  by edit a value inside defaults/main.yml it will automatiquelly make consistant setting.

run_log script:
- Value "/var/log" have been replace by "{{ glx_log_dir }}"
- Value "/var/log" inside "conf-log" file have been replace by {{ glx_log_dir }}
- Value "nofiles" it make reference to nofiles group have been replace by {{ glx_sqmail_groups.nofiles.gname }}, "conf-ids", "conf-users" and  "conf-groups" use the same method then the log script recive consitent informations.
- Value "qmaill" it make reference to sqmail Log user have been replace by {{ glx_sqmail_ids.qmaill.uname }}, "conf-ids", "conf-users" and  "conf-groups" use the same method then the log script recive consitent informations.
todo: Reference to "multilog" group , it make reference to daemontools group name should be dynamic; actually Galaxie design use daemontools Debian package but soon, daemontools will be dedicated to s/qmail, then the multilog username or UID will be under s/qmail control.

run_pop3d script:
- Value "/var/qmail" have been replace by {{ glx_qmail_dir }}
- Value "Maildir" it suppose to be the maildirname have been replace by {{ glx_sqmail_control_defaultdelivery }} it store "Mailbox", {{ glx_sqmail_control_defaultdelivery }} is use during "defaultdelivery" control file creation, like that glx_sqmail_control_defaultdelivery: "./{{ glx_sqmail_control_defaultdelivery }}/"
todo: HOSTNAME should store same value a control/me file

run_pop3sd script:
- Value "/var/qmail" have been replace by {{ glx_qmail_dir }}
- Value "Maildir" it suppose to be the maildirname have been replace by {{ glx_sqmail_control_defaultdelivery }} it store "Mailbox", {{ glx_sqmail_control_defaultdelivery }} is use during "defaultdelivery" control file creation, like that glx_sqmail_control_defaultdelivery: "./{{ glx_sqmail_control_defaultdelivery }}/"
todo: HOSTNAME should store same value a control/me file

run_qmqpd script:
- Value "/var/qmail" have been replace by {{ glx_qmail_dir }}
- Value "qmaild" it make reference to sqmail Daemon user have been replace by {{ glx_sqmail_ids.qmaild.uname }}, "conf-ids", "conf-users" and  "conf-groups" use the same method then the log script recive consitent informations.

run_qmtpd script:
- Value "/var/qmail" have been replace by {{ glx_qmail_dir }}
- Value "qmaild" it make reference to sqmail Daemon user have been replace by {{ glx_sqmail_ids.qmaild.uname }}, "conf-ids", "conf-users" and  "conf-groups" use the same method then the log script recive consitent informations.

run_qmtpsd script:
- Value "/var/qmail" have been replace by {{ glx_qmail_dir }}
- Value "qmaild" it make reference to sqmail Daemon user have been replace by {{ glx_sqmail_ids.qmaild.uname }}, "conf-ids", "conf-users" and  "conf-groups" use the same method then the log script recive consitent informations.

run_send script:
- Value "/var/qmail" have been replace by {{ glx_qmail_dir }}
- Value "./Maildir/ have been replace by {{ glx_sqmail_control_defaultdelivery }}, exactelly same value as defaultdelivery control file.

run_smtpd script:
- Value "/var/qmail" have been replace by {{ glx_qmail_dir }}
- Value "qmaild" it make reference to sqmail Daemon user have been replace by {{ glx_sqmail_ids.qmaild.uname }}, "conf-ids", "conf-users" and  "conf-groups" use the same method then the log script recive consitent informations.

run_smtpsd script:
- Value "/var/qmail" have been replace by {{ glx_qmail_dir }}
- Value "qmaild" it make reference to sqmail Daemon user have been replace by {{ glx_sqmail_ids.qmaild.uname }}, "conf-ids", "conf-users" and  "conf-groups" use the same method then the log script recive consitent informations.

run_smtpsub script:
- Value "/var/qmail" have been replace by {{ glx_qmail_dir }}
- Value "qmaild" it make reference to sqmail Daemon user have been replace by {{ glx_sqmail_ids.qmaild.uname }}, "conf-ids", "conf-users" and  "conf-groups" use the same method then the log script recive consitent informations.

ssl.env file:
- Value "SQMTLS" it make reference to "sqmail TLS user" have been replace by {{ glx_sqmail_ids.sqmtls.uname }}
- Value "NOFILES" it make reference to "sqmail group for auxiliar files" have been replace by {{ glx_sqmail_groups.nofiles.gname }}
- Value "QMAIL" it make reference to "/var/qmail" directory have been replace by {{ glx_qmail_dir }}

## Role Variables

A maxium of variables have been set that for permit fine tuning inside host_var or group_var

Here the lists:
yet (You can found it on ./defaults/main.yml)

we have make our maximum for have explicite variable name, that should minimize the need of details.


## Dependencies

Systemd and Rsyslog are default package on GNU/Debian systems

## Example Playbook

as do by ../sqmail-server.yml all default value are inside ./defaults/main.yml file

    - hosts: sqmail-servers
    
      roles:
         - sqmail-server

## License

GPL 3

## Author Information

Tuux from www/rtnp.org