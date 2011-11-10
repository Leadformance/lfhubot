# The welcome on board script location
#
# tell me the truth about <query> - Returns sentence by person

module.exports = (robot) ->
  robot.respond /tell me the truth about (.+)/i, (msg) ->
    query  = msg.match[1]
    if role_name in ["vzmind", "vincent"]
      msg.send "You know Vz is really awesome, even awesomer than me, so hard to tell you more"
    else
      msg.send "For sure it's 42"
