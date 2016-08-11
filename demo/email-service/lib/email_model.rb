class EmailModel

	attr_accessor :id, :from, :to, :subject, :body

  def initialize(from, to, subject, body, id=nil)
    @from = from
    @to = to
    @subject = subject
    @body = body
    @id = id
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