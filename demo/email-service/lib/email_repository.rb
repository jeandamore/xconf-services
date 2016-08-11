require 'mail'

class EmailRepository
  include Singleton

  attr_reader :emails

	def initialize
    @emails = Array.new
  end  

  def add(email)
    mail = Mail.new do
  		from    email.from
  		to      email.to
  		subject email.subject
  		body    email.body
  	end
    mail.delivery_method :sendmail
  	mail.deliver!
  	email.id = mail.to_s
  	emails << email
  end 

end