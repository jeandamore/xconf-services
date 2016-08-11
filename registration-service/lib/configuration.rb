require 'ostruct'

class Configuration

  @@config = OpenStruct.new({

    :local => {
    	:account_service => 'http://account-service:4001'
   	},
    :production => {
    	:account_service => 'http://account-service:3001'
    }

  })

  def self.value value
  	@@config[ENV['XENVIRONMENT'].to_sym][value.to_sym]
  end

end