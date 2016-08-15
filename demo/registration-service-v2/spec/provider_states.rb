require 'pact/provider/rspec'

require_relative '../lib/rabbitmq_proxy'

Pact.provider_states_for 'client' do

  provider_state 'the service is ready' do
    set_up do
      # Your set up code goes here
    end
  end

  provider_state 'new user' do
    set_up do
      # Your set up code goes here
    end
  end

  provider_state 'user already exists' do
    set_up do
  		RabbitMqProxy.new(Configuration.value :rabbitmq).post('user', 'existing_user@email.com')
    end
  end

end