require 'rubygems'
require 'sinatra'

cap = "~/.rvm/bin/bridge_cap"
url = "http://jarvis.leadformance.com/"

get '/' do
  "GTFO n00b"
end

get '/deploy/:stage/:branch' do
  timestamp = Time.now.strftime('%Y%m%d%H%M')
  logfile = "log/deploy-#{timestamp}.log"
  loghtml = "log/deploy-#{timestamp}.html"

  cmd = "cd ~/apps/bridge;"

  if %w(feature production).include?(params[:stage])
    cmd += "git checkout development; git pull origin development"
  else
    # 2.89 is the latest tag pointing to 1.9.3-p327
    cmd += "git checkout 2.89"
  end

  cmd = IO.popen("#{cmd}; #{cap} #{params[:stage]} deploy tag=#{params[:branch]}")
  log = cmd.readlines

  File.open(logfile, 'w') do |f|
    f.write log.join
  end

  html = IO.popen("cat #{logfile} | bin/ansi2html.sh --bg=dark > #{loghtml}")
  "Deployed ! Traces : #{url}#{loghtml}"
end
