# Description
#   Fabric connector to Hubot
#
# Configuration:
#   HUBOT_FABRIC_MAPPING_FILE
#
# Commands:
#   hubot FABFILE_ALIAS [OPTIONS] - Calls fabfile defined in HUBOT_FABRIC_MAPPING_FILE json file and passes all OPTIONS if any
#
# Author:
#   aleszoulek


{exec} = require 'child_process'
fs = require 'fs'

FABFILES = {}

MAPPING_FILE = process.env.HUBOT_FABRIC_MAPPING_FILE or ''
if MAPPING_FILE
  FABFILES = JSON.parse(fs.readFileSync MAPPING_FILE)

RESPOND_TO = []
for key, value of FABFILES
    RESPOND_TO.push key
RESPOND_TO_RE = new RegExp("(#{RESPOND_TO.join('|')})(?: (.*))?", "i")


module.exports = (robot) ->
  robot.respond RESPOND_TO_RE, (msg) ->
    fabAlias = msg.match[1]
    fabArgs = msg.match[2]
    fabFile = FABFILES[fabAlias]
    command = "fab -f #{fabFile} --abort-on-prompts"

    if fabArgs
      command = "#{command} #{fabArgs}"
    else
      command = "#{command} -l"

    msg.send "Calling #{command}"

    fab = exec command
    fab.stderr.on 'data', (data) ->
      for line in data.toString().split('\n')
        msg.send "E> " + line
    fab.stdout.on 'data', (data) ->
      for line in data.toString().split('\n')
        msg.send "O> " + line
    fab.on 'exit', (code) ->
      if code == 0
        msg.send "Done #{command}."
      else
        msg.send "FAILED #{command}. Returned #{code}"

