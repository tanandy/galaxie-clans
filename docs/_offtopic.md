# Tech resources

> To learn about the main different software bricks we use.

## jisti-meet

* [Jitsi Videobridge Performance Evaluation](https://jitsi.org/jitsi-videobridge-performance-evaluation/)
* [](https://www.speedguide.net/port.php?port=3478)
* [](https://meetrix.io/blog/webrtc/jitsi/jitsi-meet-and-firewalls.html)
* [](https://meetrix.io/blog/webrtc/jitsi/setting-up-a-turn-server-for-jitsi-meet.html)
* [](https://github.com/jitsi/jitsi-meet/issues/797)
* [](https://meetrix.io/blog/webrtc/jitsi/meet/installing.html)

## peertube

* [Docker compose example](https://yerbamate.dev/nutomic/peertube.social/src/branch/master/templates/docker-compose.yml)

## I2P & Co

* [i2pd container image](https://hub.docker.com/r/meeh/i2pd)
* [privoxy container image](https://hub.docker.com/r/splazit/privoxy-alpine)

## Mailserver

* https://www.malekal.com/installer-configurer-spamassassin-debian/
* https://wiki.debian.org/DebianSpamAssassin

cpu wait vs user wait

diminuer le

rmem_default
A kernel parameter that controls the default size of receive buffers used by sockets. To configure this, run the following command:

sysctl -w net.core.rmem_default=N

Replace N with the desired buffer size, in bytes. To determine the value for this kernel parameter, view /proc/sys/net/core/rmem_default. Bear in mind that the value of rmem_default should be no greater than rmem_max (/proc/sys/net/core/rmem_max); if need be, increase the value of rmem_max.

## Netdata

https://docs.netdata.cloud/docs/performance/

## TODO

* host and distribute rootfs alpine & debian.

# Work In Progress

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

icecast
shoutcast

# Nice PeerTube list

```
If you find a dead link, open an issue.
```

p.eertu.be
peertube.at
videos.lavoixdessansvoix.org
tube.gnous.eu
video.fitchfamily.org
peer.mathdacloud.ovh
videos.gerdemann.me
gab.com
tube.fede.re
peertube.mateofix.xyz
porntube.ddns.net
peertube.ventresmous.fr
peertube.kangoulya.org
videos.domainepublic.net
tube.fab-l3.org
video.wivodaim.net
peertube.club
tube.chatelet.ovh
video.autizmo.xyz
stream.okin.cloud
peertube.anduin.net
peertube.1312.media
tube.crapaud-fou.org
peertube.kosebamse.com
manicphase.me
peertube.bierzilla.fr
video.fediverso.net
peertube.nomagic.uk
tube.lesamarien.fr
tube.odat.xyz
peer.philoxweb.be
tube.backbord.net
tube.bootlicker.party
tube.kicou.info
video.blueline.mg
vault.mle.party
fightforinfo.com
peertube.makotoworkshop.org
tube.govital.net
video.ploud.jp
vloggers.social
peertube.video
video.subak.ovh
peertube.heraut.eu
peertube.me
video.taboulisme.com
peertube.normandie-libre.fr
tube.thechangebook.org
peertube.gegeweb.eu
tube.h3z.jp
peertube.fedi.quebec
tube.plus200.com
tube.4aem.com
tube.ouahpiti.info
peertube.snargol.com
peertube.social
hitchtube.fr
alttube.fr
medias.libox.fr
tube.plaf.fr
peertube.zapashcanon.fr
hostyour.tv
peertube.live
yunopeertube.myddns.me
peertube.cyber-tribal.com
peertube.mygaia.org
video.g3l.org
video.colibris-outilslibres.org
video.antopie.org
tube.taker.fr
o.urtu.be