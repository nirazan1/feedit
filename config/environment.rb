# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

PUSHER_APP_ID = ENV['PUSHER_APP_ID']
PUSHER_KEY = ENV['PUSHER_KEY']
PUSHER_SECRET = ENV['PUSHER_SECRET']
