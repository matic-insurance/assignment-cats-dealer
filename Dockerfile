FROM ruby:2.6-alpine

ENV APP_HOME=/cats_dealer
ENV BUNDLER_VERSION=2.1.4
ENV CLOUDSDK_PYTHON=python3

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      postgresql-dev \
      python3 \
      python3-dev \
      tzdata \
      yarn

RUN gem install bundler -v 2.1.4

WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install

#COPY package.json yarn.lock ./
#RUN yarn install --check-files

COPY . ./

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]