FROM ruby:3.2.8

# Node.js & Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get update && apt-get install -y nodejs build-essential libpq-dev && \
    npm install -g yarn

WORKDIR /app

# JS依存関係を先にインストール
COPY package.json yarn.lock ./
RUN yarn install

# Rails依存関係をインストール
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリ全体をコピー
COPY . .


