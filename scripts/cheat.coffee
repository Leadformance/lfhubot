# Interacts with the cheats
#
# cheat me <query> - Returns a cheat link returned by `query` on http://cheat.errtheblog.com.

module.exports = (robot) ->
  robot.respond /cheat me (.+)/i, (msg) ->
    query  = msg.match[1]
    url      = "http://cheat.errtheblog.com/s/" + query
    msg.send url

