require 'sinatra/base'
require 'json'

require_relative 'email_model'
require_relative 'email_repository'
require_relative 'rss_reader'
require_relative 'configuration'
require_relative 'rabbitmq_proxy'

class EmailService < Sinatra::Base

  def initialize
    @repository = EmailRepository.instance
    @reader = RssReader.new(Configuration.value :rss_service)
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
      message: "Email Service is up",
      port: ENV['RACK_PORT'],
      emails: @repository.emails.map { |e| e.id } 
    })
    status 200
  end

  get '/rss/:channel' do
    @reader.read(params['channel']).each do |item|
      email = EmailModel.new(
        'rss@xconf.com', 
        item.title, 
        'Welcome', 
        item.description
      )
      @repository.add(email)
    end
    status 200
  end

  get '/rabbitmq/user' do
    @rabbitmq.receive('user') { | email |
      email = EmailModel.new(
        'rss@xconf.com', 
        email, 
        'Welcome', 
        'Welcome'
      )
      @repository.add(email)
    }
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