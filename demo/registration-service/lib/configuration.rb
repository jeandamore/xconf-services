require 'ostruct'

class Configuration

  @@config = OpenStruct.new({

    :development => {
    	:account_service => 'http://account-service:8080',
      :email_service => 'http://email-service:8080'
   	},
    :production => {
    	:account_service => 'http://account.corsamore.com',
      :email_service => 'http://email.corsamore.com'
    }

  })

  def self.value value
  	@@config[ENV['XENVIRONMENT'].to_sym][value.to_sym]
  end

end