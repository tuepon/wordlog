FROM ruby:3.0.6

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get update && apt-get install -y nodejs build-essential libpq-dev && \
    npm install -g yarn

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

EXPOSE 3000

CMD ["bin/dev"]
