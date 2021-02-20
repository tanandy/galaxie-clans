******************************
How to test roles?
******************************

Ready?
======
2 methods:

* sudo NOPASSWD
* ansible-vault NOPASSW

* ansible-vaulted file located at ``molecule/utils/group_vars/all/vault.yml``

.. code:: yaml

    ansible_become_password: "yourpassword"

* your ansible vault password stated in ``.vault_password_file`` at the project root.
* Just in case, run a little:

.. code:: bash

    direnv reload

