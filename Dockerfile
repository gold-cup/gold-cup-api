FROM ruby:3.0.3-alpine

RUN apk -U add --no-cache \
    build-base \
    git \
    postgresql-dev postgresql-client \
    mariadb-dev \
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

RUN bundle install

# ENTRYPOINT ["/bin/bash"]
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]