# TODO

* Postfix secondary
* Log rotation + rsyslog ?

bind cache enable
nginx cache enable

jitsi nat transversal
reduire la plage de port media


rsyslog
ufw en DENY uniquement
deny all
allow uniquement l'autorisé : SSH + webserver + imap + smtp
methode:
  prio SSH
  reglages sans le deny all, confirmation par les compteurs que les regles sont utilisées
  enfin: en fin => deny all


depot de template site-available
gestion de available + enabled


https://gitlab.com/Tuuux/galaxie-curses/raw/master/docs/source/images/logo_galaxie.png


palabre = avec S



# Pannes latentes
## Log merdique de JVB

Grosses boucles de ça dans les logs:
```
mars 23 00:10:52 vana docker-compose[19315]: jvb_1      | JVB 2020-03-23 00:10:51.807 WARNING: [423112] org.jitsi.impl.neomedia.transform.RtxTransformer.log() Cannot find SSRC for RTX,
```