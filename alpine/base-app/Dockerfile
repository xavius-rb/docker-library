FROM ruby:2.6-alpine
RUN apk add --no-cache --quiet \
    build-base \
    postgresql-dev \
    sqlite-dev \
    tzdata \
    nodejs \
    yarn

RUN gem install thor
COPY bin/xavius /usr/local/bin
RUN chmod +x /usr/local/bin/xavius

RUN mkdir /opt/rails
COPY templates/* /opt/rails/

RUN mkdir -p /usr/src/app

WORKDIR /home

CMD ["/bin/sh"]
