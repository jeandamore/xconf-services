require 'pact/provider/rspec'

require_relative './../lib/configuration'
require_relative './../lib/account_service_proxy.rb'

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
  		AccountServiceProxy.new(Configuration.value :account_service).post 'existing_user@email.com'
    end
  end

end