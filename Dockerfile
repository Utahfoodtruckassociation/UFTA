FROM ruby:2.4-alpine
LABEL maintainer="Dallin Johnson <dallin.b.johnson@gmail.com>"

RUN apk update && apk add build-base nodejs postgresql-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs \
    && bundle update

COPY . .

RUN bin/rails assets:precompile 


CMD puma -C config/puma.rb
