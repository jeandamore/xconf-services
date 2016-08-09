require 'sinatra/base'
require 'json'

module AccountService

  class Api < Sinatra::Base

    set :raise_errors, false
    set :show_exceptions, false

    error do
      e = env['sinatra.error']
      content_type :json
      status 500
      {error: e.message, backtrace: e.backtrace}.to_json
    end

    get '/' do
      "Account Service is up"
    end

    get '/:name' do
      content_type :json
      {:name => "#{params['name']}", :balance => 42}.to_json
    end

  end
end
