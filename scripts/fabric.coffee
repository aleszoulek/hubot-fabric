module.exports = (robot) ->
  robot.respond /fabric (.*)/i, (msg) ->
    fabFile = msg.match[1]
    msg.reply "fab #(fabFile)"

