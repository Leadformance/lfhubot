# Description:
#   Deploy with capistrano
#
# Commands:
#  hubot deploy <stage> <branch>
#  hubot  what can you deploy?


#hackers = [
#  "http://hubot-assets.s3.amazonaws.com/hackers/1.gif",
#  "http://hubot-assets.s3.amazonaws.com/hackers/2.gif",
#  "http://hubot-assets.s3.amazonaws.com/hackers/3.gif",
#  "http://hubot-assets.s3.amazonaws.com/hackers/4.gif",
#  "http://hubot-assets.s3.amazonaws.com/hackers/5.gif",
#  "http://hubot-assets.s3.amazonaws.com/hackers/6.gif",
#  "http://hubot-assets.s3.amazonaws.com/hackers/7.gif",
#]

#array of the stage names to match and deploy to
stage = [
  "staging",
  "qa",
  "clientqa"
  "preprod"
  "production"
  "sandbox"
  "integrator"
  "feature"
]

module.exports = (robot) ->
  robot.respond /deploy (.*) (.*)/i, (msg) ->
    if msg.match[1] in stage
      msg.send 'Attempting deploy. Please hold.'
      #hit the sinatra app to do the deploy
      msg.http("http://localhost:4567/deploy/#{msg.match[1]}/#{msg.match[2]}")
      .get() (err, res, body) ->
        if res.statusCode == 404
          msg.send 'Something went horribly wrong'
        else
          msg.send 'Deployed like a boss'
          msg.send body
    else
      msg.send 'Nope. I dont know what that is. Try deploying one of these: ' + stage.join(", ")


  robot.respond /(what can you deploy?)/i, (msg) ->
    msg.send 'I can deploy the shit out of ' + stage.join(", ")

  robot.respond /(test)/i, (msg) ->
    msg.http("http://localhost:4567/")
    .get() (error, response, body) ->
      msg.send body

  robot.hear /(.*)@(.*):(.*) The build passed.(.*)/i, (msg) ->
    switch msg.match[2]
      when "development" 
        msg.send "Deploying on the staging server."
        msg.http("http://localhost:4567/deploy/staging/#{msg.match[3]}")
        .get() (err, res, body) ->
          if res.statusCode == 404
            msg.send 'Something went horribly wrong'
          else
            msg.send body
      when "release" 
        msg.send "Deploying on the qa server."
        msg.http("http://localhost:4567/deploy/qa/#{msg.match[3]}")
        .get() (err, res, body) ->
          if res.statusCode == 404
            msg.send 'Something went horribly wrong'
          else
            msg.send body
      when "production" 
        msg.send "Deploying on the prelive server."
        msg.http("http://localhost:4567/deploy/prelive/#{msg.match[3]}")
        .get() (err, res, body) ->
          if res.statusCode == 404
            msg.send 'Something went horribly wrong'
          else
            msg.send body
      else msg.send "I can't autodeploy that branch sir !"