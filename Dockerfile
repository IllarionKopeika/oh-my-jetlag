FROM ruby:3.3

RUN echo "deb [check-valid-until=no] http://snapshot.debian.org/archive/debian/20241115T000000Z trixie main" > /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until \"false\";" > /etc/apt/apt.conf.d/99disable-check-valid-until && \
    apt-get update -o Acquire::AllowInsecureRepositories=true -qq && \
    apt-get install -y --allow-unauthenticated \
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
