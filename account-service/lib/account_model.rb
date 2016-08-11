
class AccountModel

	attr_accessor :name, :balance

  def initialize(name, balance=0)
    @name = name
    @balance = balance
  end  

end