require 'ostruct'

class Configuration

  @@config = OpenStruct.new({

    :development => {
      :rabbitmq => 'rabbitmq',
      :queue => 'registered-v1.1.0'
   	},
    :production => {
      :rabbitmq => 'rabbitmq.corsamore.com',
      :queue => 'registered-v1.1.0'
    }

  })

  def self.value value
  	@@config[ENV['XENVIRONMENT'].to_sym][value.to_sym]
  end

end