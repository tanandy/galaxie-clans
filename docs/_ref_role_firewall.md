[Galaxie-Clans Documentation](README.md) / [Reference Guides](_REF__.md)

# Role: firewall

## DRAFT

* ufw

ufw en DENY uniquement
deny all
allow uniquement l'autorisé : SSH + webserver + imap + smtp
methode:
  prio SSH
  reglages sans le deny all, confirmation par les compteurs que les regles sont utilisées
  enfin: en fin => deny all

* Fail2ban