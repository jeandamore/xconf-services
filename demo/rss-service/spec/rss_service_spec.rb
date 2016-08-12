require_relative 'spec_helper'

require 'rss_service'
require 'rack/test'

describe 'RssService' do

  include Rack::Test::Methods

  def app
    RssService.new
  end

  it "shoud have a GET health endpoint" do
    get '/health'
    expect(last_response.status).not_to eq(404)
  end

  it "shoud have a GET RSS feed endpoint" do
    get '/rss'
    expect(last_response.status).not_to eq(404)
  end

end