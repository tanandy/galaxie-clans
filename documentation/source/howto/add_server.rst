******************************
How to integrate a new server?
******************************

Ready?
======

You need:

* a Debian 10 server with ssh access and `su` or `sudo` privilege

Set.
====

Bear in mind that we use:

* ``new_server`` as the hostname
* ``$NEW_SERVER_IPV4`` as the host ipv4 public address

.. note::

    As you go on the copy-paste way, *replace* these occurences with meaningful values for your case.


Go!
===

Generate a key for your host
----------------------------

Run:

.. code:: bash

    ssh-keygen -t ed25519 -f ./keys/new_server.key -C "caretaker@new_server" -N ""


Configure SSH client
--------------------

Add a block to your ``ssh.cfg``:

.. code:: apacheconf

    Host new_server
        Hostname $NEW_SERVER_IPV4
        User caretaker
        IdentityFile ./keys/new_server.key
        IdentitiesOnly yes


Update ansible inventory
------------------------

You should have:

* a group named ``clans`` with ``new_server`` as a member

At the simplest, add this to the ``hosts`` file:

.. code:: ini

    [clans]
    new_server

.. admonition:: CONGRATULATIONS
    :class: important

    You now have local configuration ready to perform `galaxie-clans` installation!

Install ``caretaker`` user access
---------------------------------

We have setup local configuration as expected, now we need to override these sweet connection options to match
reality of your unprepared server. 

Run:

.. code:: bash

    ansible-playbook playbooks/clan_caretaker_install.yml \
        -e scope=new_server $EXTRA_CONNECTION_OPTIONS


.. important::

    This $EXTRA_CONNECTION_OPTIONS is to be replaced by your specific (and unique) case!
 
    You can pick in these:
    * `-e ansible_ssh_user=your_default_user` to set a specific connection user
    * `-k` to have ansible prompt for SSH password
    * `-K` to have ansible prompt for become method password
    * `--become` to elevate privileges after connection
    * `--become-method=su` to rely on `su` instead of `sudo` for privilege escalation

Validate access
---------------

.. code:: bash

    ansible -m ping new_server --become


It should give you a *glorious*:

.. code:: bash

    new_server | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
