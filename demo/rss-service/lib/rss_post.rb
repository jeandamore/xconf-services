require 'securerandom'

class RssPost

	attr_accessor :guid, :channel, :version, :title, :body, :created_at

  def initialize(channel, version, title, body)
  	@guid = SecureRandom.uuid
  	@channel = channel
  	@version = version
  	@title = title
    @body = body
    @created_at = Time.new 
  end 

  def as_json()
    {
      guid: @guid,
      channel: @channel,
      version: @version,
      title: @title,
      body: @body,
      created_at: @created_at
    }
  end 

end