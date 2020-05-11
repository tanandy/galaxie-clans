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



# Documentation guidelines

Borrowed from Daniele Procida's presentation at PyCon Australia: "What nobody tells you about documentation". Thanks to him. https://documentation.divio.com/

write documentation overview explaining the documentation chapters and their goals

## Tutorials
### Learning oriented.

Lessons that take the read by the hand through a series of steps to complete a project.

What matters:

* learning by doing
* getting started
* inspiring confidence
* repeatability
* immediate step of confidence
* concreteness, not abstraction
* minimum necessary explaination
* no distractions

## How-to Guides
### Problem-oriented

Guides that take the reader through a series of steps required to solve a common problem.

What matters:

* a series of steps
* a focus on the goal
* addressing a specific questions
* no unnecessary explanation
* a little flexibily
* practical usability
* good naming

## References
### Information-oriented

Technical descriptions of the machinery and how to operate it.

* 

## Explanations
### Understanding-oriented

Explanations that clarify and illuminate a particular topic.

What matters:

* giving context
* explaining why
* multiple examples, alternative approaches
* making connections
* no instructions or technical description
