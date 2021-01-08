**************************************************
Tutorial: Found a Galaxie Clan on a Kimsufi server
**************************************************

This tutorial will guide you through installing a fresh clan instance on a Kimsufi server, from zero to
all services enabled. 

.. note::
    This is no marketing bullshit intending to push you into renting a Kimsufi server.
    This is only based on our available infrastructure at the time of writing.

Ready?
======

* Have a ready `galaxie-clans` workspace (see [How to setup a galaxie-clans workspace](_howto_setup.md)).
* Have a [Kimsufi](https://www.kimsufi.com/) server, installed with the template `Debian 9 (Stretch) (64bits)`.
* Validate you are able to log as `root`.
* Configure a DNS to delegate a SOA to your server.

Set.
====

* We will call our host `kimserver`. If you want to rename it, be aware to replace any occurence in the following steps.
* We will use the label `$KIM_IPV4` instead of a real IP address. replace with actual values when following instructions.
* The domain that `kimserver` is SOA for, will be named `tuto.galaxie.clans`. Replace any occurence in the following steps with the domain you chose.
* The name of the clan we are founding is `kimclan`
* All commands are to be run from the root of your `galaxie-clans` workspace.

Go!
===

Add `kimserver` to managed servers
----------------------------------

* **Generate a key for later connections**

Run:
```
ssh-keygen -t ed25519 -f ./keys/kimserver.key -C "caretaker@kimserver" -N ""
```

* **Configure SSH client**

Add a block to your `ssh.cfg`:
.. code::

    Host kimserver
        Hostname $KIM_IPV4
        User caretaker
        IdentityFile ./keys/kimserver.key
        IdentitiesOnly yes

* **Update ansible inventory**

You should have:

* a group named `kimclan` with `kimserver` as a member
* the `kimclan` group as a child of the `clans` group

Add this to the `hosts` file:

.. code::

    [clans:children]
    kimclan

    [kimclan]
    kimserver


.. important::
    Congratulations! You now have your server at hand to perform `galaxie-clans` installation!

Upgrade to Debian Buster
------------------------

* **Perform in-place upgrade**

.. code:: bash

    ansible-playbook playbooks/debian_upgrade_version.yml -e scope=kimserver -e ansible_ssh_user=root -k

Install `caretaker` user access
-------------------------------

.. code:: bash

    ansible-playbook playbooks/clan_caretaker_install.yml -e scope=kimserver -e ansible_ssh_user=root -k

Validate accesses
-----------------

.. code:: bash

    ansible -m ping kimserver


It should give you a **glorious**:

.. code:: bash

    kimserver | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }

.. important::

    Congratulations! You now have a normalized `caretaker` access to ease management of your server by ansible!

Configure services
------------------

* **Create host variables file**

.. code:: bash

    mkdir host_vars/kimserver
    echo '---' > host_vars/kimserver/main.yml

* **Configure host variables**

Edit `host_vars/kimserver/main.yml` file. Add:

.. code:: yaml

    system_base_domain: "tuto.galaxie.clans"
    dns_enable: yes
    mailserver_enable: yes
    rproxy_enable: yes
    chat_enable: yes
    videoconf_enable: yes
    calendar_enable: yes

Deploy services
---------------

.. admonition:: DEPLOY

    .. code:: bash

        ansible-playbook playbooks/setup_core_services.yml -e scope=kimserver
        ansible-playbook playbooks/acme_rotate_certificates.yml -e scope=kimserver
        ansible-playbook playbooks/setup_broadcast_services.yml -e scope=kimserver

.. admonition:: Enjoy!
    :class: important

    Your clan is founded!

    Welcome in the galaxie-clans's community.

    From now on you can search documentation for other materials and go further in the rabbit hole.
