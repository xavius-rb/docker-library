FROM ruby:3.0-alpine
RUN apk add --no-cache --quiet \
    build-base \
    curl \
    git \
    postgresql-dev \
    sqlite-dev \
    tzdata \
    nodejs-npm \
    yarn

RUN mkdir -p /usr/src/app
ENV APP_ROOT=/usr/src/app

WORKDIR $APP_ROOT

RUN mkdir /opt/xavius
COPY templates/* /opt/xavius/

ARG BUNDLE_GEMFILE=Gemfile
ENV BUNDLE_GEMFILE=${BUNDLE_GEMFILE}

CMD ["/bin/sh"]
