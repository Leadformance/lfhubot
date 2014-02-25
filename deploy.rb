require 'rubygems'
require 'sinatra'
 
get '/' do
  "GTFO n00b"
end
 
 
#pass in the repo name and deploy that shit
get '/deploy/:stage/:branch' do
    bb = IO.popen("cd ~/apps/bridge ; git pull origin production ; cap "+params[:stage]+" deploy:migrations tag="+params[:branch]+" ;")
    b = bb.readlines
    puts b.join
end