FROM ruby:3.3

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  curl \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

# RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bash", "-c", "bundle exec rails db:prepare && bundle exec puma -C config/puma.rb"]
