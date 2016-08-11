FROM ruby:2.3.1

# Install the gems
WORKDIR /tmp/email-service
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --without development test

# Copy the app
COPY . /home/email-service
WORKDIR /home/email-service

# Create user for the app
RUN useradd -m email-service-user -G users
RUN chown -R email-service-user /home/email-service
USER email-service-user

# Run the app
ENV XENVIRONMENT=production
ENV RACK_ENV=production
ENV RACK_PORT=3002
CMD ["bundle", "exec", "rake", "--rakefile", "Rakefile.dock", "server:run"]