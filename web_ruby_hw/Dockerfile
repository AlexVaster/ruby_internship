FROM ruby:2.7-alpine

ENV SRC_PATH /app
RUN mkdir -p $SRC_PATH
WORKDIR $SRC_PATH

COPY . .

EXPOSE 5678

CMD ["ruby", "web_server.rb"]