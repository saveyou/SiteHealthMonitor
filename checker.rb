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
begin
  resp = HTTP.get(SITE)
  if resp.status.to_i == 200
    p "Live"
    send_alert(SAFE_MESSAGE)
  else
    p "Site Down"
    send_alert(WARNING_MESSAGE)
  end
rescue Exception => e
  puts e.message
  puts e.backtrace.inspect
  p "Site Down"
  send_alert(WARNING_MESSAGE)
end
p "Done"