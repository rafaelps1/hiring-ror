FROM ruby:3.0

ENV LANG C.UTF-8
ENV APP_DIR /usr/src/app

WORKDIR ${APP_DIR}

RUN gem install rails

COPY Gemfile Gemfile.lock ./

RUN (bundle check || bundle install)
