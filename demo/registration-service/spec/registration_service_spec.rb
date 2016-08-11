require_relative 'spec_helper'

require 'registration_service'
require 'rack/test'

describe 'RegistrationService' do

  include Rack::Test::Methods

  def app
    RegistrationService.new
  end

  it "shoud have a GET health endpoint" do
    get '/health'
    expect(last_response.status).not_to eq(404)
  end

  it "shoud have a POST registration endpoint" do
    post '/'
    expect(last_response.status).not_to eq(404)
  end

end