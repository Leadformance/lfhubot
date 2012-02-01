Hubot
=====

This is a version of GitHub's Campfire bot, hubot. He's pretty cool.

This version is designed to be deployed on heroku.

Playing with Hubot
==================

You'll need to install the necessary dependencies for hubot. All of
those dependencies are provided by [npm](http://npmjs.org).

    % bin/hubot

You'll see some startup output about where your scripts come from.

    Loading deploy-local scripts at /Users/me/nubot/scripts
    Loading hubot core scripts for relative scripts at /Users/me/nubot/src/hubot/scripts
    Hubot: the Shell.
    { id: '1', name: 'Shell' }
    Loading hubot-scripts from /Users/me/nubot/hubot-scripts.json
    Successfully connected to Redis

Then you can interact with Hubot by typing `hubot help`.

    hubot help

    animate me <query> - The same thing as `image me`, except adds a few
    convert me <expression> to <units> - Convert expression to given units.
    help - Displays all of the help commands that Hubot knows about.
    ...

Take a look at the scripts in the `./scripts` folder for examples.
Delete any scripts you think are silly.  Add whatever functionality you
want hubot to have.


hubot-scripts
=============

There will inevitably be functionality that everyone will want. Instead
of adding it to hubot itself, you can submit pull requests to
[hubot-scripts](https://github.com/github/hubot-scripts). To enable
scripts from the hubot-scripts package, add the script name with extension as a
double quoted string to the hubot-scripts.json file in this repo.

Deployment
==========

    % heroku create --stack cedar
    % git push heroku master
    % heroku ps:scale app=1
    % heroku addons:add redistogo:nano

If you run into any problems, checkout heroku's [docs](http://devcenter.heroku.com/articles/node-js).

You'll need to edit the `Procfile` to say what the bot's name is.

Hubot also needs three environmental variables set to run and to keep him
running on heroku.

Campfire Variables
------------------

Create a separate user for your bot and get their token from the web UI.

    % heroku config:add HUBOT_CAMPFIRE_TOKEN="..."

Get the numeric ids of the rooms you want the bot to join, comma
delimited. If you want the bot to connect to `https://mysubdomain.campfirenow.com/room/42`
and `https://mysubdomain.campfirenow.com/room/1024` then you'd add it like this:

    % heroku config:add HUBOT_CAMPFIRE_ROOMS="42,1024"

Add the subdomain hubot should connect to. If you web URL looks like
`http://mysubdomain.campfirenow.com` then you'd add it like this:

    % heroku config:add HUBOT_CAMPFIRE_ACCOUNT="mysubdomain"

IRC Variables
------------------

    % heroku config:add HUBOT_IRC_SERVER="irc.freenode.net"

    % heroku config:add HUBOT_IRC_ROOMS="#github,#node.js"

    % heroku config:add HUBOT_IRC_NICK="MICCHECK1212"

Twilio Variables
------------------

You must have a Twilio account with credit and a number that can send and
receive SMS messages.

    % heroku config:add HUBOT_SMS_FROM="+14156662671"

    % heroku config:add HUBOT_SMS_SID="AC5d10e5624da757326d12f8d31c08c20b"

    % heroku config:add HUBOT_SMS_TOKEN="4ada63e18146a204e468fb6289030231"

After getting Hubot up and running, update the "SMS Request URL" for your
Twilio number to point to your Hubot instance.

Restart the bot
---------------
You may want to get comfortable with `heroku logs` and `heroku restart`
if you're having issues.
=======
# Hubot

This is a version of GitHub's Campfire bot, hubot. He's pretty cool.

**You'll probably never have to hack on this repo directly.**

Instead this repo provides a library that's distributed by `npm` that you
simply require in your project. Follow the instructions below and get your own
hubot ready to deploy.

## Getting your own

Make sure you have [node.js][nodejs] and [npm][npmjs] (npm comes with node v0.6.5+) installed.

Download the [latest version of hubot][hubot-latest].

Then follow the instructions in the [README][readme] in the extracted `hubot`
directory.

[nodejs]: http://nodejs.org
[npmjs]: http://npmjs.org
[hubot-latest]: https://github.com/github/hubot/downloads
[readme]: https://github.com/github/hubot/blob/master/src/templates/README.md

## Adapters

Adapters are the interface to the service you want your hubot to run on. This
can be something like Campfire or IRC. There are a number of third party
adapters that the community have contributed. Check the
[hubot wiki][hubot-wiki] for the available ones and how to create your own.

Please submit issues and pull requests for third party adapters to the adapter
repo not this repo unless it's the Campfire or Shell adapter.

[hubot-wiki]: https://github.com/github/hubot/wiki
[third-party-adapters]: https://github.com/github/hubot/tree/master/src/adapters/third-party
[split-subpath]: http://help.github.com/split-a-subpath-into-a-new-repo/
[logjs]: https://github.com/visionmedia/log.js

## hubot-scripts

Hubot ships with a number of default scripts, but there's a growing number of
extras in the [hubot-scripts][hubot-scripts] repository. `hubot-scripts` is a
way to share scripts with the entire community.

Check out the [README][hubot-scripts-readme] for more help on installing
individual scripts.

[hubot-scripts]: https://github.com/github/hubot-scripts
[hubot-scripts-readme]: https://github.com/github/hubot-scripts#readme

## HTTP Listener

Hubot has a HTTP listener which listens on the port specified by the `PORT`
environment variable.

You can specify routes to listen on in your scripts by using the `router`
property on `robot`.

```coffeescript
module.exports = (robot) ->
  robot.router.get "/hubot/version", (req, res) ->
    res.end robot.version
```

There are functions for GET, POST, PUT and DELETE, which all take a route and
callback function that accepts a request and a response.

## Testing hubot locally

Install all of the required dependencies by running `npm install`.

It's easy to test scripts locally with an interactive shell:

    % export PATH="node_modules/.bin:$PATH"
    % bin/hubot

... and to run unit tests:

    % make test