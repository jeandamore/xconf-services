require 'singleton'

class AccountRepository
  include Singleton

	def initialize
    @accounts = Array.new
  end  

	def add(account)
		@accounts << account
	end

	def find(name)
		@accounts.find { |a| a.name == name }
	end

	def exists?(name)
		@accounts.any? { |a| a.name == name }
	end

end