require 'sinatra'
require 'json'

require_relative 'rss_post'

class RssService < Sinatra::Base

	set :views, File.dirname(__FILE__) + '/../views'
	set :raise_errors, true
	set :show_exceptions, true

  error do
    e = env['sinatra.error']
    content_type :json
    status 500
    {error: e.message, backtrace: e.backtrace}.to_json
  end

  get '/health' do
    content_type :json
    body JSON.generate({
      message: "Rss Service is up"
    })
    status 200
  end
	
	get '/rss' do
	  @posts = Array.new
	  @posts << RssPost.new(1, 'My first post', 'Life is sweet')
	  builder :rss
	end

end