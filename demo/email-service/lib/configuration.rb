require 'ostruct'

class Configuration

  @@config = OpenStruct.new({

    :development => {
    	:rss_service => 'http://rss-service:8080'
   	},
    :production => {
    	:rss_service => 'http://rss.corsamore.com'
    }

  })

  def self.value value
  	@@config[ENV['XENVIRONMENT'].to_sym][value.to_sym]
  end

end