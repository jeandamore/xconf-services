require 'httparty'
require 'json'

class AccountServiceProxy

	def initialize(url) 
		@url = url
	end

	def get existing_account
		HTTParty.get(@url+'/'+existing_account)
	end

	def post new_account
		HTTParty.post(
			@url,
    	:headers => { 'Content-Type' => 'application/json' },
			:body => { :name => new_account }.to_json
    )
	end

end
