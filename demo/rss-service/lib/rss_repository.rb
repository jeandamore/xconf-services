require 'singleton'

class RssRepository
  include Singleton

  attr_reader :posts

	def initialize
    @posts = Hash.new
  end  

	def add(post)
		if exists?(post.channel, post.title) 
			nil
		else
			add_post post
		end
	end

	def find(channel, title)
		channel = @posts[channel]
		if channel.nil?
			nil
		else
			channel.find {|p| p.title == title }
		end
	end

	def exists?(channel, title)
		channel = @posts[channel]
		if channel.nil?
			false
		else
			channel.any? {|p| p.title == title }
		end
	end

	private

	def add_post(post)
		channel = @posts[post.channel]
		if channel.nil?
			channel = Array.new
			channel << post
			@posts[post.channel] = channel
		else
			channel << post
		end
	end

end