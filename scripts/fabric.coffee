# Description
#   Fabric connector to Hubot
#
# Configuration:
#   HUBOT_FABRIC_MAPPING
#   HUBOT_FABRIC_SKIP_LINES_PATTERN
#
# Commands:
#   hubot FABFILE_ALIAS [OPTIONS] - Calls fabfile defined in HUBOT_FABRIC_MAPPING environmental variable in query string format alias1=/path/to/fabfile1.py&alias2=/tmp/fab2.py
#
# Author:
#   aleszoulek


{exec} = require 'child_process'
querystring = require 'querystring'

FABFILES = querystring.parse(process.env.HUBOT_FABRIC_MAPPING)

SKIP_LINES_PATTERN = new RegExp(process.env.HUBOT_FABRIC_SKIP_LINES_PATTERN or '^\s*$')

RESPOND_TO = []
for key, value of FABFILES
    RESPOND_TO.push key
RESPOND_TO_RE = new RegExp("(#{RESPOND_TO.join('|')})(?: (.*))?", "i")




module.exports = (robot) ->
  if not process.env.HUBOT_FABRIC_MAPPING
    robot.logger.warning 'The HUBOT_FABRIC_MAPPING environment variable is set not going to load fabric.coffee'
    return

  robot.respond RESPOND_TO_RE, (msg) ->
    send = (text, prefix='') ->
      if not SKIP_LINES_PATTERN.test(text)
        msg.send prefix+text

    fabAlias = msg.match[1]
    fabArgs = msg.match[2]
    fabFile = FABFILES[fabAlias]
    command = "fab -f #{fabFile} --abort-on-prompts"

    if fabArgs
      command = "#{command} #{fabArgs}"
    else
      command = "#{command} -l"

    send "Calling #{command}"

    fab = exec command
    fab.stderr.on 'data', (data) ->
      for line in data.toString().split('\n')
        send line, 'Error: '
    fab.stdout.on 'data', (data) ->
      for line in data.toString().split('\n')
        send line
    fab.on 'exit', (code) ->
      if code == 0
        send "Done #{command}."
      else
        send "FAILED #{command}. Returned #{code}"

