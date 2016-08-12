FROM ruby:2.3.1

# Install the gems
WORKDIR /tmp/rss-service
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --without development test

# Copy the app
COPY . /home/rss-service
WORKDIR /home/rss-service

# Create user for the app
RUN useradd -m rss-service-user -G users
RUN chown -R rss-service-user /home/rss-service
USER rss-service-user

# Run the app
ENV XENVIRONMENT=production
ENV RACK_ENV=production
ENV RACK_PORT=8080
CMD ["bundle", "exec", "rake", "--rakefile", "Rakefile.dock", "server:run"]