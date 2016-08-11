require 'sinatra/base'
require 'json'

require_relative 'configuration'
require_relative 'account_service_proxy'
require_relative 'email_service_proxy'

class RegistrationService < Sinatra::Base

  def initialize
    @account_service = AccountServiceProxy.new(Configuration.value :account_service)
    @email_service = EmailServiceProxy.new(Configuration.value :email_service)
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
      message: "Registration Service is up",
      port: ENV['RACK_PORT'] 
    })
  end

  post '/' do
    if @account_service.get(params[:email.to_s]).code == 200
      status 422
    else
      status @account_service.post(params[:email.to_s]).code
      @email_service.post('registration@thoughtworks.com', params[:email.to_s], 'Welcome', 'Thanks for registering with us!')
    end
  end

end
