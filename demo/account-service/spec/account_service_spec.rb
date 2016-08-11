require_relative 'spec_helper'

require 'account_service'
require 'rack/test'

describe 'AccountService' do

  include Rack::Test::Methods

  def app
    AccountService.new
  end

  it "shoud have a GET health endpoint" do
    get '/health'
    expect(last_response.status).not_to eq(404)
  end

  it "shoud have a GET account endpoint" do
    get '/name'
    expect(last_response.status).not_to eq(404)
  end

  it "shoud have a POST account endpoint" do
    post '/'
    expect(last_response.status).not_to eq(404)
  end

end