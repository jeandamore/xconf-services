require 'sinatra/base'
require 'json'

require_relative 'configuration'
require_relative 'account_service_proxy'

class RegistrationService < Sinatra::Base

  def initialize
    @account_service = AccountServiceProxy.new(Configuration.value :account_service)
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
    "Registration Service is up"
  end

  post '/' do
    if @account_service.get(params[:email.to_s]).code == 200
      status 422
    else
      status @account_service.post(params[:email.to_s]).code
    end
  end

end
