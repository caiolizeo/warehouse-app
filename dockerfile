FROM ruby:3.0.3

ENV NODE_VERSION 16

RUN curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN apt install --no-install-recommends yarn

RUN mkdir app
WORKDIR /app
COPY . /app
RUN bundle install
RUN ruby bin/setup

EXPOSE 3000
ENTRYPOINT rails s -b 0.0.0.0