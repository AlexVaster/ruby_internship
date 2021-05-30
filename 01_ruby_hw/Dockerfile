FROM ruby:2.7-buster

ENV SRC_PATH /app
RUN mkdir -p ${SRC_PATH}
WORKDIR ${SRC_PATH}

ADD . .

CMD ["ruby", "vm_counter.rb", "10"]
