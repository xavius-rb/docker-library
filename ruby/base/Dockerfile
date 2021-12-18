FROM ruby:3-alpine

RUN apk add --no-cache \
    build-base \
    git \
    postgresql-dev \
    tzdata \
    npm

RUN npm install -g yarn@1.22.17

ENV APP_ROOT=/usr/src/app
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

CMD ["/bin/sh"]
