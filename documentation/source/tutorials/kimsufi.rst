###########################
Install on a Kimsufi server
###########################

This tutorial will guide you through installing a fresh clan instance on a Kimsufi server, from zero to
all services enabled. 

.. note::

    This is no marketing bullshit intending to push you into renting a Kimsufi server.
    This is only based on our available infrastructure at the time of writing.

Ready?
******

* Have a ready `galaxie-clans` workspace (see [How to setup a galaxie-clans workspace](_howto_setup.md)).
* Have a `Kimsufi <https://www.kimsufi.com/>`_ server, installed with the template ``Debian 9 (Stretch) (64bits)``.
* Validate you are able to log as `root`.
* Configure a DNS to delegate a SOA to your server.

Set.
****

* We will call our host ``kimserver``. If you want to rename it, be aware to replace any occurence in the following steps.
* We will use the label ``$KIM_IPV4`` instead of a real IP address. replace with actual values when following instructions.
* The domain that ``kimserver`` is SOA for, will be named ``tuto.galaxie.clans``. Replace any occurence in the following steps with the domain you chose.
* The name of the clan we are founding is ``kimclan``
* All commands are to be run from the root of your ``galaxie-clans`` workspace.

Go!
***

First contact
=============

Generate ssh keypair
--------------------

Run:

.. code:: bash

    ssh-keygen -t ed25519 -f ./keys/kimserver.key -C "caretaker@kimserver" -N ""

Configure ssh client
--------------------

Add to ``$WORKSPACE/ssh.cfg``:

.. code:: apacheconf

    Host kimserver
        Hostname $KIM_IPV4
        User caretaker
        IdentityFile ./keys/kimserver.key
        IdentitiesOnly yes

Update ansible inventory
------------------------

Add to ``$WORKSPACE/hosts``:

.. code::

    [clans:children]
    kimclan

    [kimclan]
    kimserver

System upgrade
--------------

Run:

.. code:: bash

    ansible-playbook playbooks/debian_upgrade_version.yml -e scope=kimserver -e ansible_ssh_user=root -k

------

.. admonition:: CONGRATULATIONS
    :class: important
    
    You now have an up-to-date Kimsufi server at hand to perform **galaxie-clans** installation.

------

Ansible access
==============

Install normalized user access
------------------------------

Run:
.. code:: bash

    ansible-playbook playbooks/clan_caretaker_install.yml -e scope=kimserver -e ansible_ssh_user=root -k

Validate ansible accesses
-------------------------

Run:

.. code:: bash

    ansible -m ping kimserver


Expected in stdout:

.. code:: bash

    kimserver | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }


------

.. admonition:: CONGRATULATIONS
    :class: important

    You now have a normalized user access to ease management of your server by ansible.

------

Service configuration
=====================

Create host variables file
--------------------------

Run:

.. code:: bash

    mkdir host_vars/kimserver
    echo "---" > host_vars/kimserver/main.yml

Configure host variables
------------------------

Add to ``$WORKSPACE/host_vars/kimserver/main.yml``
    
.. code:: yaml

    system_base_domain: "tuto.galaxie.clans"
    dns_enable: yes
    mailserver_enable: yes
    rproxy_enable: yes
    chat_enable: yes
    videoconf_enable: yes
    calendar_enable: yes

------

Services deployment
===================

Run:

.. code:: bash

    ansible-playbook playbooks/setup_core_services.yml -e scope=kimserver
    ansible-playbook playbooks/acme_rotate_certificates.yml -e scope=kimserver
    ansible-playbook playbooks/setup_broadcast_services.yml -e scope=kimserver

----

.. admonition:: CONGRATULATIONS
    :class: important

    Your clan is founded!

    Welcome in the galaxie-clans's community.

    From now on you can search documentation for other materials and go further in the rabbit hole.

----

.. admonition:: HEADSHOT SCRIPT
    :class: danger

    .. code:: bash

        echo "this should be fine..."