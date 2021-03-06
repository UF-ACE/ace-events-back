FROM ruby:2.7-alpine

WORKDIR /usr/src

RUN apk add --no-cache --update build-base postgresql-dev tzdata

ENV RAILS_ENV production

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --without development test

COPY . .

EXPOSE 8080
CMD ["rails", "s"]