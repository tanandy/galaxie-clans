[Galaxie-Clans Documentation](README.md) / [How-to Guides](_HOWTO__.md)

# How to setup a `galaxie-clans` workspace ?

## Ready?

* Have `git` installed.
* Have `make` installed.
* Have `python > 3.7.3` installed 
  * [OSX Guide](https://seleniumgithub.wordpress.com/2020/02/08/how-to-set-python3-as-default-on-your-macos)
  * [Ubuntu Guide](https://www.itsupportwale.com/blog/how-to-upgrade-to-python-3-8-on-ubuntu-18-04-lts)
* Have `direnv` [installed](https://direnv.net/docs/installation.html) and [hooked](https://direnv.net/docs/hook.html) to your shell.
* Have `virtualenv` installed (linked to your python3)

## Go!

### Clone the project

```
git clone https://gitlab.com/Tuuux/galaxie-clans.git
cd galaxie-clans
```

### Install requirements

```
make requirements
```

> Congratulations! You now have a `galaxie-clans` workspace at hand!

## EOC