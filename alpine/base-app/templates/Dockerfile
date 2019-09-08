FROM xavius/base

ARG RAILS_ENV=development
ENV RAILS_ENV=${RAILS_ENV}
ARG BUNDLE_GEMFILE=Gemfile
ENV BUNDLE_GEMFILE=${BUNDLE_GEMFILE}
ENV RAILS_ROOT=/usr/src/app

WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock package.json yarn.lock $RAILS_ROOT/

RUN set -ex; \
  if [ "$RAILS_ENV" = "production" ]; then \
    bundle install --jobs 5 --retry 3 --without test development; \
  else \
    bundle install --jobs 5 --retry 3; \
  fi;

RUN set -ex; \
  if [ "$RAILS_ENV" = "production" ]; then \
    yarn install --no-cache --frozen-lockfile --production; \
  elif [ "$RAILS_ENV" = "test" ]; then \
    yarn install --no-cache --frozen-lockfile; \
  fi;

COPY . $RAILS_ROOT

RUN set -ex; \
  if [ "$RAILS_ENV" = "production" ]; then \
    RAILS_ENV=production \
    DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname \
    SECRET_TOKEN=abcd \
    bin/rails assets:precompile; \
  fi;

CMD bundle exec puma -C config/puma.rb
