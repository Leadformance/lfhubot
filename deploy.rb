require 'rubygems'
require 'sinatra'

cap = "~/.rvm/bin/bridge_cap"
url = "http://jarvis.leadformance.com/"

get '/' do
  "GTFO n00b"
end

get '/deploy/:stage/:branch' do
  logfile = "log/deploy-"+Time.now.strftime('%Y%m%d%H%M')+".log"
  cmd = IO.popen("cd ~/apps/bridge ; git pull origin production ; ~/.rvm/bin/bridge_cap "+params[:stage]+" deploy tag="+params[:branch]+" ;")
  log = cmd.readlines
  File.open(logfile, 'w') do |f|
      f.write log.join
  end
  "Deploy Traces : "+url+logfile
end

