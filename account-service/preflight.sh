rvm use 2.3.1
rvm gemset create account-service
rvm gemset use account-service
gem install bundle
bundle install
bundle exec rake spec