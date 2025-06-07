# In your Sinatra app (app.rb or similar)
require 'sinatra'

# Set version from environment variable or use default
APP_VERSION = ENV['APP_VERSION'] || '1.0.0'

get '/version' do
  content_type :text
  APP_VERSION
end

get '/health' do
  status 200
  'OK'
end