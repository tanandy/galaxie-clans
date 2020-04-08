# Galaxie Clans Guidelines

![galaxie](images/logo_galaxie.png)

## Over the top

* Debian: because it's "The Universal Operating System"
* Ansible: because it's "Simple, agentless IT automation that anyone can use"
* Every component should be open-source, popular and have a big contributor community

## Then

* Roles should be highly customizable by variables
* The design must permit easy upgrade

## Release naming

* Major release are named after the runes names of the elder Futhark.

## BACKLOG

### Firewalling

* ufw

ufw en DENY uniquement
deny all
allow uniquement l'autorisé : SSH + webserver + imap + smtp
methode:
  prio SSH
  reglages sans le deny all, confirmation par les compteurs que les regles sont utilisées
  enfin: en fin => deny all

* Fail2ban

### Log centralization
* rsyslog

### Caching

* bind cache enable
* nginx cache enable (examples in role for other role integration)
* SSH compression level + sessions persistentes

## Pannes latentes
### Log merdique de JVB

Grosses boucles de ça dans les logs:
```
mars 23 00:10:52 vana docker-compose[19315]: jvb_1      | JVB 2020-03-23 00:10:51.807 WARNING: [423112] org.jitsi.impl.neomedia.transform.RtxTransformer.log() Cannot find SSRC for RTX,
```


## Color Palette

* Black `#001516`
* Grey `#ccccccff`
* Cyan `#8ef4f7`
* Cyan strong `#6bd1d4`
