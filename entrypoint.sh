#!/bin/sh
set -e

echo "Checking database connection..."
while ! pg_isready -h "$POSTGRESQL_HOST" -p "$POSTGRESQL_PORT" -U "$POSTGRESQL_USER" >/dev/null 2>&1; do
  echo "Waiting for database..."
  sleep 2
done

echo "Database is ready. Running migrations..."
bin/rails db:migrate RAILS_ENV=production

echo "Starting Rails server..."
exec bin/rails server -b 0.0.0.0 -p 3000
