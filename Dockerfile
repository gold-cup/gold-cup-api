FROM ruby:3.0.3-alpine

RUN apk -U add --no-cache \
    build-base \
    git \
    postgresql-dev postgresql-client \
    mariadb-dev mariadb-client \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    yarn \
    sqlite sqlite-dev \
    imagemagick \
    tzdata \
    less \
    && rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app
RUN chmod +x ./entrypoint.sh

ENV PORT=3000

RUN bundle install

ENTRYPOINT [ "./entrypoint.sh" ]