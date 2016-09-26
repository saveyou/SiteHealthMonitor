require 'twilio-ruby'
require 'http'

# put your own credentials here
account_sid = 'XXX'
auth_token = 'XXX'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

# alternatively, you can preconfigure the client like so
Twilio.configure do |config|
  config.account_sid = account_sid
  config.auth_token = auth_token
end

# and then you can create a new client without parameters
@client = Twilio::REST::Client.new

#HTTP.timeout(:global, :write => 1, :connect => 1, :read => 1)
begin
  resp = HTTP.get("http://www.example.id")
  if resp.status.to_i == 200
    p "Live"
  else
    p "Site Down"
    @client.messages.create(
        from: '+6285574679583',
        to: '+6285769800705',
        body: 'Example Down'
    )
  end
rescue Exception => e
  puts e.message
  puts e.backtrace.inspect
  @client.messages.create(
      from: '+6285574679583',
      to: '+6285769800705',
      body: 'Lirikbagus Down'
  )
  p "Site Down"
end

p "Done"