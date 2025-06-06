# # frozen_string_literal: true

# require 'sinatra/base'
# require 'sinatra/json'
# require 'net/http'

# module Cats
#   class Web < Sinatra::Base
#     configure do
#       set :url, URI('http://thecatapi.com/api/images/get').freeze
#     end

#     get '/' do
#       json url: Net::HTTP.get_response(settings.url)['location']
#     end
#   end
# end

# frozen_string_literal: true

require 'sinatra/base'
require 'net/http'

module Cats
  class Web < Sinatra::Base
    configure do
      set :url, URI('https://thecatapi.com/api/images/get').freeze

      enable :logging
      use Rack::CommonLogger, $stdout
    end

    # Health endpoint for Kubernetes
    get '/health' do
      status 200
      'OK'
    end

    get '/' do
      image_url = Net::HTTP.get_response(settings.url)['location']

      <<~HTML
        <!DOCTYPE html>
        <html>
          <head>
            <title>Here's a Cat! 🐱</title>
            <style>
              body { text-align: center; font-family: Arial, sans-serif; margin-top: 50px; }
              img { max-width: 90%; height: auto; border-radius: 12px; box-shadow: 0 0 20px rgba(0,0,0,0.2); }
            </style>
          </head>
          <body>
            <h1>Here's a Cat! 🐱</h1>
            <img src="#{image_url}" alt="A random cat image" />
          </body>
        </html>
      HTML
    end

    # Start the app and bind to 0.0.0.0 so Kubernetes can reach it
    run! host: '0.0.0.0', port: 8000 if app_file == $0
  end
end
