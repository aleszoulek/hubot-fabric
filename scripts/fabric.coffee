FABFILES = {
    'foo': '/tmp/fab/foo.py',
    'bar': '/tmp/fab/bar.py',
}

RESPOND_TO = []
for key, value of FABFILES
    RESPOND_TO.push key
RESPOND_TO_RE = new RegExp("(#{RESPOND_TO.join('|')})(?: (.*))?", "i")

{exec} = require 'child_process'

module.exports = (robot) ->
  robot.respond RESPOND_TO_RE, (msg) ->
    fabAlias = msg.match[1]
    fabArgs = msg.match[2]
    fabFile = FABFILES[fabAlias]
    command = "fab -f #{fabFile}"

    if fabArgs
      command = "#{command} #{fabArgs}"
    else
      command = "#{command} -l"

    msg.reply "Calling #{command}"

    fab = exec command
    fab.stderr.on 'data', (data) ->
      for line in data.toString().split('\n')
        msg.reply "E> " + line
    fab.stdout.on 'data', (data) ->
      for line in data.toString().split('\n')
        msg.reply "O> " + line
    fab.on 'exit', (code) ->
      if code == 0
        msg.reply "Done #{command}."
      else
        msg.reply "FAILED #{command}. Returned #{code}"

