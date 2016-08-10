require_relative 'spec_helper'

require 'account_service'
require 'rack/test'

describe 'AccountService' do

  include Rack::Test::Methods

  def app
    AccountService::Api.new
  end

  it "shoud have a GET health endpoint" do
    get '/'
    expect(last_response.status).to eq(200)
  end

  it "shoud have a GET account endpoint" do
    get '/name'
    expect(last_response.status).to eq(200)
  end

end