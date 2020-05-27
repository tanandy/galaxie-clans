# Galaxie - Clans

> Every gamer needs a clan.
> Find here everything a gamer [clan](https://en.wikipedia.org/wiki/Clan) needs to live in the [Information Age](https://en.wikipedia.org/wiki/Information_Age).

* **Who is it for?**: Litteraly every group of friend willing to communicate over Internet.
* **Why do this?**:
  * Because we can.
  * Because Open-Source is cool.
  * For the fun.

### Host prerequisites

* [Debian Stable](https://www.debian.org/): with ipv4 (and ideally with ipv6 interface too)
* SSH access: as root or full sudo
* NS domain delegation

## Trunk Services

### Big Picture

![galaxie](docs/images/big_picture.png)

### Core (BLACK)

Core services are installed at the operating system level.

* **SYSTEM_BASE**: Mandatory system configuration, impacts [ntpd](http://www.ntp.org/), [openssh](https://www.openssh.com/) and sysctl tweaking.
* **SYSTEM_USERS**: Role to manage system users deployment.
* **DNS**: Based on [bind](https://www.isc.org/bind/)
* **FIREWALL**: Based on [ufw](https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29)
* **MONITOR**: Based on [netdata](https://www.netdata.cloud/)
* **BACKUP**: Based on [rsync](https://rsync.samba.org/)
* **MAILSERVER**: Based on [postfix](http://www.postfix.org/) & [dovecot](https://www.dovecot.org/)

### High-Level Hub (GREY)

High-level Hub services are installed at the operating system level. These are the mandatory os-level services to build upon for higher-level services.

* **CONTAINER**: Based on [containerd](https://containerd.io/). It is installed at the operating system level. Every higher-level services are to be run by docker-compose-centric system services.
* **RPROXY**: Based on [nginx](https://www.nginx.com/). It is installed at the operating system level. The reverse proxy feature is used to expose
other services by domain name.

#### Broadcast (CYAN)

The following bricks are run as docker-compose files started by a systemd service. Data persistence is ensured by host-bound volumes.

* **CALENDAR**: Based on [radicale](https://radicale.org/)
* **CHAT**: Based on [mattermost](https://mattermost.com/)
* **VIDEOCONF**: Based on [jitsi-meet](https://jitsi.org/jitsi-meet/)

## Once upon a time...

Once upon a time, this project was hosted on a ancient platform called GitHub. Then came the Buyer. The Buyer bought GitHub, willing to rule over its community. We were not to sell, so here is the new home of "https://github.com/Tuuux/galaxie", and the project has mutated since then...

We build an Ansible toolkit for managing a set of Debian servers, a set of powerful roles made hand-in-hand by a senior system admin and a senior developer.

Originaly written for managing a Home Network with external services. The project has shifted to managing digital survival of clanic entities.

Galaxie-Clans is a true mix of the two world, by luck author Tuuux and Mo have made the necessary to have no compromise.

Bear in mind folks: Tech purity is cancer of mind.

It would be an honor if you could use our work in any way. Be it as-is or as code samples.
