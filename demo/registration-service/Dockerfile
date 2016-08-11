FROM ruby:2.3.1

# Install the gems
WORKDIR /tmp/registration-service 
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --without development test

# Copy the app
COPY . /home/registration-service
WORKDIR /home/registration-service

# Create user for the app
RUN useradd -m registration-service-user -G users
RUN chown -R registration-service-user /home/registration-service
USER registration-service-user

# Run the app
ENV XENVIRONMENT=production
ENV RACK_ENV=production
ENV RACK_PORT=8080
CMD ["bundle", "exec", "rake", "--rakefile", "Rakefile.dock", "server:run"]