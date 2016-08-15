rvm use 2.3.1
rvm gemset create registration-service
rvm gemset use registration-service
gem install bundle
bundle install
bundle exec rake spec