require 'singleton'

class AccountRepository
  include Singleton

	def initialize
    @accounts = Array.new
  end  

	def add(account)
		if exists?(account.name) 
			nil
		else
			@accounts << account
			account
		end
	end

	def find(name)
		@accounts.find { |a| a.name == name }
	end

	def exists?(name)
		@accounts.any? { |a| a.name == name }
	end

end