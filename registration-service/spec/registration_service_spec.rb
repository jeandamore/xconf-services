require_relative 'spec_helper'

require 'registration_service'
require 'rack/test'

describe 'RegistrationService' do

  include Rack::Test::Methods

  def app
    RegistrationService::Api.new
  end

  it "shoud have a GET health endpoint" do
    get '/'
    expect(last_response.status).to eq(200)
  end

  it "shoud have a POST registration endpoint" do
    post '/'
    expect(last_response.status).to eq(200)
  end

end