# syntax=docker/dockerfile:1
FROM ruby:3.3.5-slim

WORKDIR /rails

RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    build-essential curl git libpq-dev libyaml-dev pkg-config \
    nodejs npm postgresql-client libjemalloc2 libvips && \
    npm install --global yarn && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development test" \
    RAILS_LOG_TO_STDOUT=true \
    PORT=3000

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

COPY . .

EXPOSE 3000

CMD ["sh", "-lc", "bin/rails db:prepare && bin/rails assets:precompile && bin/rails server -b 0.0.0.0 -p 3000"]
