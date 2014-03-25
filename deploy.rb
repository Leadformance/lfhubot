require 'rubygems'
require 'sinatra'

cap = "~/.rvm/bin/bridge_cap"
url = "http://jarvis.leadformance.com/"

get '/' do
  "GTFO n00b"
end

get '/deploy/:stage/:branch' do
  timestamp = Time.now.strftime('%Y%m%d%H%M')
  logfile = "log/deploy-"+timestamp+".log"
  loghtml = "log/deploy-"+timestamp+".html"
  cmd = IO.popen("cd ~/apps/bridge ; git pull origin production ; ~/.rvm/bin/bridge_cap "+params[:stage]+" deploy tag="+params[:branch]+" ;")
  log = cmd.readlines
  File.open(logfile, 'w') do |f|
      f.write log.join
  end
  html = IO.popen("cat "+logfile+" | bin/ansi2html.sh --bg=dark > "+loghtml)
  "Deploy Traces : "+url+loghtml
end

