FROM xavius/base

COPY package.json yarn.lock $APP_ROOT/
COPY . $APP_ROOT

RUN bin/bundle install
RUN bin/yarn install --frozen-lockfile

CMD "Done"
