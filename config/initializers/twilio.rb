require 'rubygems'
require 'twilio-ruby'

# put your own credentials here
account_sid = Rails.application.secrets.twilio.fetch("account_sid")
auth_token  = Rails.application.secrets.twilio.fetch("auth_token")

# set up a client to talk to the Twilio REST API
TWILIO_CLIENT = Twilio::REST::Client.new account_sid, auth_token
