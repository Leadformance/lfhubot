# Interacts with the Google Maps API.
#
# lf roles - LEADFORMANCE: Returns a link to leadformance roles.
module.exports = (robot) ->
  robot.respond /.*lf roles/i, (msg) ->
    url         = "https://sites.google.com/a/leadformance.com/product/roles"
    msg.send url

  robot.respond /who has (.*) role$/i, (msg) ->
    role_name = msg.match[1]

    response = []
    for own key, user of robot.brain.data.users

      if user.roles
        response.push user.name if role_name in user.roles

    switch response.length
      when 0 then msg.send "What ? no " + role_name + " ?"
      when 1 then msg.send "It's "+ response[0]
      else msg.send "Too many people !! (" + response.join(", ") + ") "

