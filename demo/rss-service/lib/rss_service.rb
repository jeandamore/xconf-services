require 'sinatra'
require 'sinatra/base'
require 'json'
require 'builder'

require_relative 'rss_repository'
require_relative 'rss_post'

class RssService < Sinatra::Base

  @@repository = RssRepository.instance

	set :views, File.dirname(__FILE__) + '/../views'
	set :raise_errors, true
	set :show_exceptions, true

  before do
    if request.body.size > 0
      request.body.rewind
      @params = JSON.parse request.body.read
    end
  end

  error do
    e = env['sinatra.error']
    content_type :json
    status 500
    {error: e.message, backtrace: e.backtrace}.to_json
  end

  get '/health' do
    content_type :json
    body JSON.generate({
      message: "Rss Service is up",
      port: ENV['RACK_PORT']
    })
    status 200
  end
	
	get '/' do
    content_type :xml
	  @posts = @@repository.posts
	  builder :rss
	end
	
	post '/' do
    status @@repository.add(
      RssPost.new(params[:channel.to_s], 
                  params[:version.to_s], 
                  params[:title.to_s], 
                  params[:body.to_s])).nil? ? 409 : 201
	end

end