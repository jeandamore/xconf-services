class RssPost

	attr_accessor :channel, :version, :title, :body, :created_at

  def initialize(channel, version, title, body)
  	@channel = channel
  	@version = version
  	@title = title
    @body = body
    @created_at = Time.new 
  end 

  def as_json()
    {
      channel: @channel,
      version: @version,
      title: @title,
      body: @body,
      created_at: @created_at
    }
  end 

end