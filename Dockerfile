FROM ruby:3.0.3

RUN apt install curl gcc g++ make && \
    curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && \
    apt install -y \
        git-core \
        zlib1g-dev \
        build-essential \
        ruby-dev \
        libssl-dev \
        libreadline-dev \
        libyaml-dev \
        libsqlite3-dev \
        sqlite3 \
        libxml2-dev \
        libxslt1-dev \
        libcurl4-openssl-dev \
        software-properties-common \
        libffi-dev \
        nodejs \
        yarn \
        mariadb-client libmariadb-dev \
        postgresql-client

WORKDIR /app
COPY . /app
RUN chmod +x ./entrypoint.sh

ENV PORT=3000

ENTRYPOINT [ "./entrypoint.sh" ]
