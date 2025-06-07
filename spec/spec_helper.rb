require 'spec_helper'
require 'rack/test'
require_relative '../app/web'

RSpec.describe Cats::Web do
  include Rack::Test::Methods

  def app
    ENV['APP_VERSION'] = '2.0.0' # Set version for tests
    Cats::Web.new
  end

  describe 'GET /health' do
    it 'returns 200 OK' do
      get '/health'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq('OK')
    end
  end

  describe 'GET /version' do
    it 'returns the current version' do
      get '/version'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq('2.0.0')
    end
  end

  describe 'GET /' do
    it 'includes the version in the title' do
      get '/'
      expect(last_response.body).to include('Version: 2.0.0')
    end
  end
end