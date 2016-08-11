class EmailModel

	attr_accessor :sender, :recipient, :title, :body

  def initialize(sender, recipient, title, body)
    @sender = sender
    @recipient = recipient
    @title = title
    @body = body
  end 

  def as_json()
    {
      sender: @sender,
      recipient: @recipient,
      title: @title,
      body: @body
    }
  end 

end