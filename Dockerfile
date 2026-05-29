FROM ruby:3.2.4

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get update && apt-get install -y nodejs build-essential libpq-dev && \
    curl -o- -L https://yarnpkg.com/install.sh | bash 

RUN gem install bundler -v 4.0.12 

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install
ENV PATH="/app/node_modules/.bin:$PATH"

COPY . /app

EXPOSE 3000

CMD ["bin/dev"]
