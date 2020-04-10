FROM ruby:alpine
RUN apk add --no-cache --quiet \
    build-base \
    curl \
    git \
    postgresql-dev \
    sqlite-dev \
    tzdata \
    nodejs \
    yarn

RUN mkdir -p /usr/src/app
ENV APP_ROOT=/usr/src/app

WORKDIR /usr/src/app

ARG BUNDLE_GEMFILE=Gemfile
ENV BUNDLE_GEMFILE=${BUNDLE_GEMFILE}

CMD ["/bin/sh"]
