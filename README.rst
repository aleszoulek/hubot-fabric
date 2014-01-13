HUBOT-FABRIC
============

Description
-----------

Fabric connector for hubot.


Configuration
-------------
Env variable `HUBOT_FABRIC_MAPPING` defines fabfiles and its aliases. For
example:::

    HUBOT_FABRIC_MAPPING='bar=/tmp/fab/bar.py&foo=/tmp/fab/foo.py'

Usage:
------

Use the alias to call the fabric commnds from the fabfile. When no argument is
given, fab -l is called instead::


    Hubot> hubot: bar
    Hubot> Shell: Calling fab -f /tmp/fab/bar.py -l
    Hubot> Shell: O> Available commands:
    Hubot> Shell: O> 
    Hubot> Shell: O>     host_type
    Hubot> Shell: O> 
    Hubot> Shell: Done fab -f /tmp/fab/bar.py -l.

All options are passed directly to fab::

    Hubot> hubot: bar -H localhost host_type
    Hubot> Shell: Calling fab -f /tmp/fab/bar.py -H localhost host_type
    Hubot> Shell: O> [localhost] Executing task 'host_type'
    Hubot> Shell: O> [localhost] run: echo bar
    Hubot> Shell: O> [localhost] out: bar
    Hubot> Shell: O> 
    Hubot> Shell: O> [localhost] out: 
    Hubot> Shell: O> 
    Hubot> Shell: O> 
    Hubot> Shell: O> [localhost] run: uname -s
    Hubot> Shell: O> [localhost] out: Linux
    Hubot> Shell: O> [localhost] out: 
    Hubot> Shell: O> 
    Hubot> Shell: O> 
    Hubot> Shell: O> 
    Hubot> Shell: O> 
    Hubot> Shell: O> Done.
    Hubot> Shell: O> Disconnecting from localhost... done.
    Hubot> Shell: O> 
    Hubot> Shell: Done fab -f /tmp/fab/bar.py -H localhost host_type.
    Hubot> 

