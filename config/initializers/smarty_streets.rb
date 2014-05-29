require "smarty_streets"

secrets = Rails.application.secrets.smarty_streets

SmartyStreets.configure do |c|
  c.auth_id = secrets.fetch("auth_id")
  c.auth_token = secrets.fetch("auth_token")
  c.number_of_candidates = 5
end