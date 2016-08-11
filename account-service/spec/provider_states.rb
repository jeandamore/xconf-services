require 'pact/provider/rspec'

require_relative './../lib/account_repository.rb'
require_relative './../lib/account_model.rb'

Pact.provider_states_for 'client' do

  provider_state 'the service is ready' do
    set_up do
      # Your set up code goes here
    end
  end

  provider_state 'there is no account' do
    set_up do
      # Your set up code goes here
    end
  end

  provider_state 'there is an existing account' do
    set_up do
      repository = AccountRepository.instance
      repository.add AccountModel.new("existing_account")
    end
  end

end