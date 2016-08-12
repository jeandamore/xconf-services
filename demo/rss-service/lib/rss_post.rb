class RssPost

	attr_accessor :id, :title, :body, :created_at

  def initialize(id, title, body)
  	@title = title
    @body = body
    @id = id
    @created_at = 'Now'
  end 

  def as_json()
    {
      id: @id,
      from: @from,
      to: @to,
      subject: @subject,
      body: @body
    }
  end 

end