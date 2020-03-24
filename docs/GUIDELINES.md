# Galaxie Clans Guidelines

(images/logo_galaxie.png)

## Over the top

* Debian: because it's "The Universal Operating System"
* Ansible: because it's "Simple, agentless IT automation that anyone can use"
* Every component should be open-source, popular and have a big contributor community

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




palabre = avec S



# Pannes latentes
## Log merdique de JVB

Grosses boucles de ça dans les logs:
```
mars 23 00:10:52 vana docker-compose[19315]: jvb_1      | JVB 2020-03-23 00:10:51.807 WARNING: [423112] org.jitsi.impl.neomedia.transform.RtxTransformer.log() Cannot find SSRC for RTX,
```
