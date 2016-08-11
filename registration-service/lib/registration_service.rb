require 'sinatra/base'
require 'json'


class RegistrationService < Sinatra::Base

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
    status 200
    body ''
  end

end
