require 'twilio-ruby'
require 'http'
require_relative './config'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN

def send_alert(message)
  @client.messages.create(
      from: NUM_FROM,
      to: NUM_TO,
      body: message
  )
end

#HTTP.timeout(:global, :write => 1, :connect => 1, :read => 1)
def process(site)
	begin
	  resp = HTTP.get(site)
	  p site
	  if resp.status.to_i == 200
	    p "Live"
	    now = Time.now
	    hour = now.strftime('%H')
	    minute =  now.strftime('%M')
	    send_alert(format(SAFE_MESSAGE, site)) if ["08","15","20"].include?(hour) && minute == "00"
	  else
	    p "Site Down"
	    send_alert(format(WARNING_MESSAGE, site))
	  end
	rescue Exception => e
	  puts e.message
	  puts e.backtrace.inspect
	  p "Site Down"
	  send_alert(format(WARNING_MESSAGE, site))
	end
end

SITES.each do |s|
	process(s)
	p "======="
end

p "Done"