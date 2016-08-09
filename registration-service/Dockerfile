FROM ruby:2.3.1
COPY . /home/registration-service
RUN useradd -m registration-service-user -G users
RUN chown -R registration-service-user /home/registration-service
USER registration-service-user
WORKDIR /home/registration-service
RUN gem install bundle
RUN bundle install
# Run the server
ENV RACK_ENV=production
ENV RACK_PORT=3000
CMD ["bundle", "exec", "rake", "server:run"]