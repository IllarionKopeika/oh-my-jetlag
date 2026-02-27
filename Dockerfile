FROM ruby:3.3-bookworm

RUN rm -f /etc/apt/sources.list.d/debian.sources

RUN echo "deb http://deb.debian.org/debian bookworm main" > /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y \
      build-essential \
      libpq-dev \
      curl \
      git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["bash", "-c", "bundle exec rails db:prepare && bundle exec puma -C config/puma.rb"]
