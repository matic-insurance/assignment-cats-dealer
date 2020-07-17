FROM ruby:2.6-alpine3.12

RUN apk add --no-cache --update build-base \
                                linux-headers \
                                libxml2-dev \
                                libxslt-dev \
                                sqlite-dev \
                                nodejs \
                                bash

ENV APP_HOME /cats_dealer

RUN mkdir $APP_HOME

WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

CMD bundle exec puma -C config/puma.rb