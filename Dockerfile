# syntax=docker/dockerfile:1
FROM ruby:2.7.6

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install yarn --no-install-recommends -y

WORKDIR /app
COPY . /app/

ENV BUNDLER_PATH=/bundle BUNDLE_BIN=/bundle/bin GEM_HOME=/bundle

ENV PATH="${BUNDLE_BIN}:${PATH}"

ARG BUNDLER_VERSION=2.1.4

RUN gem install bundler:${BUNDLER_VERSION}

RUN bundle install --path=${BUNDLER_PATH}

RUN yarn install --check-files
