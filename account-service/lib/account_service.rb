require 'sinatra/base'
require 'json'

require_relative 'account_repository'
require_relative 'account_model'

class AccountService < Sinatra::Base

  def initialize
    @repository = AccountRepository.instance
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
    "Account Service is up"
  end

  post '/' do
    status @repository.add(AccountModel.new(params[:name.to_s])).nil? ? 409 : 201
  end

  get '/:name' do
    content_type :json
    {:name => "#{params['name']}", :balance => 42}.to_json
  end

end