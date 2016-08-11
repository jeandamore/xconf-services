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
    account = @repository.find params[:name.to_s].to_s
    unless account.nil?
      body JSON.generate(account.as_json)
    end
    status = account.nil? ? 428 : 200
  end

end