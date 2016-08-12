
require 'bunny'

class RabbitMqProxy

	def initialize(hostname)
		@hostname = hostname
	end

	def post(queue, message) 
		conn = Bunny.new(:hostname => @hostname)
		conn.start
		ch = conn.create_channel
		q = ch.queue(queue)
		ch.default_exchange.publish(message, :routing_key => q.name)
		puts "RabbitMqProxy: Sent #{message} to queue #{queue}"
		conn.close
	end

end