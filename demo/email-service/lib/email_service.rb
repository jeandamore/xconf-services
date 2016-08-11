require 'sinatra/base'
require 'json'

require_relative 'email_model'

class EmailService < Sinatra::Base

  def initialize
  end

  before do
    if request.body.size > 0
      request.body.rewind
      @params = JSON.parse request.body.read
    end
  end

  set :raise_errors, false
  set :show_exceptions, false

  error do
    e = env['sinatra.error']
    content_type :json
    status 500
    {error: e.message, backtrace: e.backtrace}.to_json
  end

  get '/' do
    content_type :json
    body JSON.generate({
      message: "Email Service is up",
      port: ENV['RACK_PORT']
    })
    status 200
  end

  post '/' do
    status 501
  end

end