FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs ghostscript
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g yarn
RUN yarn install --check-files

RUN apt install -y openssh-server

WORKDIR /app

RUN gem install bundler
RUN apt-get install libsqlite3-dev

COPY Gemfile ./
COPY Gemfile.lock ./
RUN bundle install

COPY package.json ./
#COPY yarn.lock ./
RUN yarn install

ENV BUNDLE_GEMFILE=./Gemfile
ENV PATH=/app/bin:$PATH

EXPOSE 3000
