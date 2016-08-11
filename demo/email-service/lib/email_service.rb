require 'sinatra/base'
require 'json'

require_relative 'email_model'
require_relative 'email_repository'

class EmailService < Sinatra::Base

  def initialize
    @repository = EmailRepository.instance
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
      message: "Email Service is up",
      port: ENV['RACK_PORT'],
      emails: @repository.emails.map { |e| e.id } 
    })
    status 200
  end

  post '/' do
    email = EmailModel.new(
      params[:from.to_s], 
      params[:to.to_s], 
      params[:subject.to_s], 
      params[:body.to_s]
    )
    @repository.add(email)
    status 201
  end

end