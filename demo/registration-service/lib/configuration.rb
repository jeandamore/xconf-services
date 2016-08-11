require 'ostruct'

class Configuration

  @@config = OpenStruct.new({

    :development => {
    	:account_service => 'http://account-service:8080'
   	},
    :production => {
    	:account_service => 'http://account-service.corsamore.com'
    }

  })

  def self.value value
  	@@config[ENV['XENVIRONMENT'].to_sym][value.to_sym]
  end

end