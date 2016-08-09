FROM ruby:2.3.1
COPY . /home/account-service
RUN useradd -m account-service-user -G users
RUN chown -R account-service-user /home/account-service
USER account-service-user
WORKDIR /home/account-service
RUN gem install bundle
RUN bundle install
# Run the server
ENV RACK_ENV=production
ENV RACK_PORT=3001
CMD ["bundle", "exec", "rake", "server:run"]