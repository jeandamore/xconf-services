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
		conn.close
	end

	def subscribe(queue, &block)
		conn = Bunny.new(:hostname => @hostname)
		conn.start
		ch = conn.create_channel
		q = ch.queue(queue)
		q.subscribe(:block => true) do |delivery_info, properties, message|
  		yield message
		end
		conn.close
	end

end