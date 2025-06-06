require 'spec_helper'
require 'rack/test'
require_relative '../app/web' # update path to your app

RSpec.describe Cats::Web do
  include Rack::Test::Methods

  def app
    Cats::Web.new
  end

  describe 'GET /health' do
    it 'returns 200 OK' do
      get '/health'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq('OK')
    end
  end
end
