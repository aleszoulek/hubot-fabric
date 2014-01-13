HUBOT-FABRIC
============

Description
-----------

Fabric connector for hubot.


Configuration
-------------
Use following env varibales:


``HUBOT_FABRIC_MAPPING`` defines fabfiles and its aliases. For example:::

    HUBOT_FABRIC_MAPPING='bar=/tmp/fab/bar.py&foo=/tmp/fab/foo.py'

``HUBOT_FABRIC_SKIP_LINES_PATTERN`` regexp, defines what fabric output
to skip. Use regexp's OR (``|``) to define a list of pattens (``^fab|connecting``).
Defaults to:::

    HUBOT_FABRIC_SKIP_LINES_PATTERN='^\s*$' # (skip all empty lines).

Usage:
------

Use the alias to call the fabric commnds from the fabfile. When no argument is
given, fab -l is called instead::


    Hubot> hubot: bar
    Hubot> Shell: Calling fab -f /tmp/fab/bar.py -l
    Hubot> Shell: Available commands:
    Hubot> Shell:     host_type
    Hubot> Shell: Done fab -f /tmp/fab/bar.py -l.

All options are passed directly to fab::

    Hubot> hubot: bar -H localhost host_type
    Hubot> Shell: Calling fab -f /tmp/fab/bar.py -H localhost host_type
    Hubot> Shell: [localhost] Executing task 'host_type'
    Hubot> Shell: [localhost] run: echo bar
    Hubot> Shell: [localhost] out: bar
    Hubot> Shell: [localhost] out: 
    Hubot> Shell: [localhost] run: uname -s
    Hubot> Shell: [localhost] out: Linux
    Hubot> Shell: [localhost] out: 
    Hubot> Shell: Done.
    Hubot> Shell: Disconnecting from localhost... done.
    Hubot> Shell: Done fab -f /tmp/fab/bar.py -H localhost host_type.
    Hubot> 


Warning
-------

This plugin should be used only in closed trusted Hubot channels. Users can
easily hijack the hubot user's shell.
