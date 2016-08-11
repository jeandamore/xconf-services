require 'httparty'
require 'json'

class EmailServiceProxy

	def initialize(url) 
		@url = url
	end

	def post(from, to, subject, body)
		HTTParty.post(
			@url,
    	:headers => { 'Content-Type' => 'application/json' },
			:body => { :from => from, :to => to, :subject => subject, :body => body }.to_json
    )
	end

end
