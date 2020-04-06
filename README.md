# Galaxie - Clans

> Everything a [clan](https://en.wikipedia.org/wiki/Clan) needs to live in the [Information Age](https://en.wikipedia.org/wiki/Information_Age)
> without any compromise with the [Industry](https://en.wikipedia.org/wiki/Industry).

* **Who is it for?**: Litteraly every group of people willing to communicate over Internet.
* **Why do this?**: Because in an Open-Source world, we should not have to rely on the [Industry](https://en.wikipedia.org/wiki/Industry) to keep up with our family and friends.

## Trunk instances

### Services Big Picture

![galaxie](docs/images/big_picture.png)

### Host prerequisites

* [Debian Stable](https://www.debian.org/): with ipv4 (and ideally with ipv6 interface too)
* SSH access: as root or full sudo

### Critical (BLACK)

* **NTP**: Based on [ntpd](http://www.ntp.org/)
* **SSH**: Based on [openssh](https://www.openssh.com/)

### Core services (GREY)

Core services are installed at the operating system level.

* **DNS**: Based on [bind](https://www.isc.org/bind/)
* **MAIL**: Based on [postfix](http://www.postfix.org/) & [dovecot](https://www.dovecot.org/)
* **LOGS**: Based on [rsyslog](https://www.rsyslog.com/)
* **METRICS**: Based on [netdata](https://www.netdata.cloud/)
* **BACKUP**: Based on [borg](https://www.borgbackup.org/)
* **FIREWALL**: Based on [ufw](https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29)

### High-level Hub services (PURPLE)

High-level Hub services are installed at the operating system level. These are the mandatory os-level services to build upon for higher-level services.

* **CONTAINER**: Based on [containerd]https://containerd.io/). It is installed at the operating system level. Every higher-level services are to be run by docker-compose-centric system services.
* **R-PROXY**: Based on [nginx](https://www.nginx.com/). It is installed at the operating system level. The reverse proxy feature is used to expose
other services by domain name.

#### Broadcast services (RED)

The following bricks are run as docker-compose files started by a systemd service. Volumes are binded on the host so data can be persisted accross services restart.

* **VIDEOCONF**: Based on [jitsi-meet](https://jitsi.org/jitsi-meet/)
* **CHAT**: Based on [mattermost](https://mattermost.com/)
* **PRIVATE BROWSING**: Based on Tor and I2P and Privoxy + anonymization light, mattermost should GET previews via tor browsing. (WIP)

## Branch instances (Work in Progress)

### Core services (GREY)

* **Trunk Core Services**
* **TFTP**: Based on `tfpd`
* **PXE**: Based on `pxelinux`
* **DHCP**: Based on `dhcpd`
* **TELEPHONY**: Based on `asterisk`
* **SHARE**: Based on `samba`
* **RPITVOS**: Based on `Libreelec`
* **PVR**: Based on `TVHeadend`
* **FIREWALL** Based on `OPNSense`
* **VPN** Based on `OPNSense`

## Once upon a time...

Once upon a time, this project was hosted on a ancient platform called GitHub. Then came the Buyer. The Buyer bought GitHub, willing to rule over its community. We were not to sell, so here is the new home of "https://github.com/Tuuux/galaxie", and the project has mutated since then...

We build an Ansible toolkit for managing a set of Debian servers, a set of powerful roles made hand-in-hand by a senior system admin and a senior developer.

Originaly written for managing a Home Network with external services. The project has shifted to managing digital survival of clans entities.

Galaxie is a true mix of the two world, by luck author Tuux and Mo have made the necessary to have no compromise.

* Pure System Admin compliance
* Pure Syntax Devs compliance

It will be an honor if you could use our work in any way. Be it as-is or as code samples.
