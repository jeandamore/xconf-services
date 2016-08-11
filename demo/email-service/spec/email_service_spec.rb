require_relative 'spec_helper'

require 'email_service'
require 'rack/test'

describe 'EmailService' do

  include Rack::Test::Methods

  def app
    EmailService.new
  end

  it "shoud have a GET health endpoint" do
    get '/health'
    expect(last_response.status).not_to eq(404)
  end

  it "shoud have a POST email endpoint" do
    post '/'
    expect(last_response.status).not_to eq(404)
  end

end