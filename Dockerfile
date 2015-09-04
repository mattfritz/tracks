FROM ruby:2.2.3-slim

MAINTAINER Matt Fritz <mfritzer@gmail.com>

ENV RAILS_ENV=production
WORKDIR /var/www

RUN apt-get update && apt-get install -y build-essential libmysqlclient-dev

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install --without test development

ADD . /var/www

RUN bundle exec rake assets:precompile

CMD ["bundle", "exec", "thin", "start", "-e", "production"]
