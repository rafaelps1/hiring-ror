FROM ruby:3.0

ENV LANG C.UTF-8
ENV APP_DIR /usr/src/app

WORKDIR ${APP_DIR}

RUN gem install rails

COPY Gemfile ./

RUN (bundle check || bundle install)

ENTRYPOINT [ "rails", "s" ]

CMD [ "-b", "0.0.0.0", "-p", "3000"]
