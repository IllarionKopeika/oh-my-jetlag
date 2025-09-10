# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.3.5
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Устанавливаем зависимости
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl libjemalloc2 libvips postgresql-client nodejs npm build-essential git libpq-dev libyaml-dev pkg-config && \
    npm install --global yarn && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development test"

# Устанавливаем гемы
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    bundle exec bootsnap precompile --gemfile

# Копируем приложение
COPY . .

# Precompile assets
RUN SECRET_KEY_BASE=dummy bin/rails assets:precompile

# Создаем пользователя
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails tmp log storage db

USER 1000:1000

# Экспортируем порт, на котором будет слушать Rails
EXPOSE 3000

# Запуск Rails
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
