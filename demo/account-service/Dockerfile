FROM ruby:2.3.1

# Install the gems
WORKDIR /tmp/account-service 
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --without development test

# Copy the app
COPY . /home/account-service
WORKDIR /home/account-service

# Create user for the app
RUN useradd -m account-service-user -G users
RUN chown -R account-service-user /home/account-service
USER account-service-user

# Run the app
ENV XENVIRONMENT=production
ENV RACK_ENV=production
ENV RACK_PORT=8080
CMD ["bundle", "exec", "rake", "--rakefile", "Rakefile.dock", "server:run"]