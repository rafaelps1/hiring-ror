FROM ruby:3.0

ENV LANG C.UTF-8
ENV APP_DIR /usr/src/app

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

WORKDIR ${APP_DIR}

RUN gem install rails

COPY Gemfile Gemfile.lock ./

RUN (bundle check || bundle install)

ENTRYPOINT [ "rails", "s" ]

CMD [ "-b", "0.0.0.0", "-p", "3000"]
