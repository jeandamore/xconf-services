FROM ruby:2.3.1

# Install the gems
WORKDIR /tmp/registration-service-v2 
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --without development test

# Copy the app
COPY . /home/registration-service-v2
WORKDIR /home/registration-service-v2

# Create user for the app
RUN useradd -m registration-service-v2-user -G users
RUN chown -R registration-service-v2-user /home/registration-service-v2
USER registration-service-v2-user

# Run the app
ENV XENVIRONMENT=production
ENV RACK_ENV=production
ENV RACK_PORT=8080
CMD ["bundle", "exec", "rake", "--rakefile", "Rakefile.dock", "server:run"]