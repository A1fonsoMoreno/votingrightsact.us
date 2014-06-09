require 'rubygems'
require 'sunlight'

Sunlight::Base.api_key = Rails.application.secrets.sunlight.fetch("api_key")
