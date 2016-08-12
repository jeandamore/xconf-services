require 'rss'
require 'open-uri'


class RssReader 

  def initialize(url)
    @url = url
  end

  def read(channel)
  	items = Array.new
  	open(@url) do |rss|
  		feed = RSS::Parser.parse(rss)
  		if feed.channel.title == channel
  			feed.items.each do |item|
  				items << item
  			end
  		end
		end
		items
  end

end