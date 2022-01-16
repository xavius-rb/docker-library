ARG OS_VERSION=3-slim-bullseye
FROM ruby:$OS_VERSION

# Basic packages
RUN apt-get update
RUN apt-get install -y curl git make gcc libsqlite3-dev libpq-dev

# Default working directory
ARG APP_ROOT=/usr/src/app
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

CMD bash
