FROM ruby:2.6

ENV APP_PATH=/usr/src
WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH/
RUN bundle install

EXPOSE 8190

ADD . .

CMD ["ruby", "turnstile.rb", "1", "-p", "8190"]
