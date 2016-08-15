require 'sinatra/base'
require 'json'

require_relative 'configuration'
require_relative 'rabbitmq_proxy'

class RegistrationService < Sinatra::Base

  def initialize
    @rabbitmq = RabbitMqProxy.new(Configuration.value :rabbitmq)
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

  get '/health' do
    content_type :json
    body JSON.generate({
      message: "Registration Service v2 is up",
      port: ENV['RACK_PORT'] 
    })
  end

  post '/' do
    @rabbitmq.post(Configuration.value(:queue), params[:email.to_s])
    status 201
  end

end
