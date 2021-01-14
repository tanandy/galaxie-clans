********************************
How to Contribute documentation?
********************************

Tutorials: Learning oriented content
====================================

Create
------

* Create a file in the ``docs/source/tutorials`` directory
* Its name must match the format ``<name>.rst``

Write
-----

Keep it clear and simple. Tutorials must be lessons that take the read by the hand through a series of steps to complete a project.

*What matters:*

* learning by doing
* getting started
* inspiring confidence
* repeatability
* immediate step of confidence
* concreteness, not abstraction
* minimum necessary explaination
* no distractions

Link
----

Add this to ``docs/source/tutorials.rst`` :

.. code:: rst

    .. toctree::
        :maxdepth: 1

        tutorials/<your filename without rst extension>


How-to Guides: Problem-oriented
===============================

Create
------

* Create a file in the ``docs/source/howto`` directory
* Its name must match the format ``<name>.rst>``

Write
-----

Guides that take the reader through a series of steps required to solve a common problem.

*What matters:*

* a series of steps
* a focus on the goal
* addressing a specific questions
* no unnecessary explanation
* a little flexibily
* practical usability
* good naming

Link
----

Add this to ``docs/source/howto.rst`` :

.. code:: rst

    .. toctree::
        :maxdepth: 1

        howto/<your filename without rst extension>


---

Reference Guides: Information-oriented
======================================

Create
------

* Create a file in the ``docs/source/reference`` directory
* Its name must match the format ``<name>.rst``

Write
-----

Technical descriptions of the machinery and how to operate it.

*What matters:*

* austere and to the point
* examples to illustrate usage
* no explanation basic concepts or how to achieve achieve common tasks
* structure, tone, format must all be as consistent as those of an encyclopaedia or dictionary
* do nothing but describe

Link
----

Add this to ``docs/source/reference.rst`` :

.. code:: rst

    .. toctree::
        :maxdepth: 1

        reference/<your filename without rst extension>


Explanation Guides: Understanding-oriented
==========================================

Create
------

* Create a file in the ``docs/source/explanation`` directory
* Its name must match the format ``<name>.rst``

Write
-----

Explanations that clarify and illuminate a particular topic.

*What matters:*

* giving context
* explaining why
* multiple examples, alternative approaches
* making connections
* no instructions or technical description

Link it
-------

Add this to ``docs/source/explanation.rst`` :

.. code:: rst

    .. toctree::
        :maxdepth: 1

        explanation/<your filename without rst extension>
