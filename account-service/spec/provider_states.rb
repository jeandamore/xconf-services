require 'pact/provider/rspec'

Pact.provider_states_for 'client' do

  provider_state 'ready' do
    set_up do
      # Your set up code goes here
    end
  end

end