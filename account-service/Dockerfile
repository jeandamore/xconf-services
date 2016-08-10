FROM ruby:2.3.1
COPY . /home/account-service
RUN useradd -m account-service-user -G users
RUN chown -R account-service-user /home/account-service
USER account-service-user
WORKDIR /home/account-service
RUN gem install bundler
RUN bundle install --without development test
# Run the server
ENV RACK_ENV=production
ENV RACK_PORT=3001
CMD ["bundle", "exec", "rake", "--rakefile", "Rakefile.dock", "server:run"]