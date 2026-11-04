# Oh My Jetlag

A Rails 8 flight tracking application that allows users to log, track, and analyze their flight history. Users can add flights manually or fetch flight data from external APIs, view detailed statistics, and visualize their travel patterns.

## Tech Stack

- **Framework:** Rails 8.0.2
- **Ruby:** 3.3.5
- **Database:** PostgreSQL 15
- **Frontend:** Hotwire (Turbo + Stimulus), Bootstrap 5.3.3, Font Awesome 6.1
- **Asset Pipeline:** Propshaft with Sass
- **Background Jobs:** Solid Queue
- **Authentication:** Rails built-in `has_secure_password` with session management
- **Internationalization:** English (en) and Russian (ru)
- **Deployment:** Docker, Kamal

## Architecture

### Core Domain Models

- **User** - User accounts with email, password, and nickname
- **Flight** - Flight records with departure/arrival airports, times, duration, distance, status (upcoming/completed), and type (domestic/international)
- **Airport** - Airport information including code, name, timezone, coordinates, and country
- **Airline** - Airline details with code, name, and logo
- **Aircraft** - Aircraft model information with manufacturer details
- **UserFlight** - Join table linking users to their flights
- **Country/Region/Continent** - Geographic hierarchy for statistical analysis

### Key Features

1. **Flight Management**
   - Fetch flight data from AeroDataBox API via RapidAPI
   - Manual flight entry
   - Automatic flight completion via background jobs
   - Flight search and map visualization

2. **Statistics & Analytics**
   - Flight statistics (count, routes, distance, duration)
   - Airport statistics
   - Airline statistics
   - Aircraft statistics
   - Geographic statistics (by country/region/continent)

3. **Rating System**
   - User rankings based on flight activity

### Services Layer

- `Flights::FlightFetcher` - Fetches flight data from external API
- `Flights::FlightCalculator` - Calculates flight metrics
- `Flights::ManualAddFlight` - Handles manual flight creation
- `Stats::*` - Various statistics calculation services
- `Ratings::Rating` - User rating calculations

### Background Jobs

- `CalculateFlightJob` - Calculates flight duration, distance, and status
- `CompleteFlightJob` - Automatically marks flights as completed after arrival
- `UpdateAircraftJob`, `UpdateAirlineJob`, `UpdateAirportJob` - Sync reference data

## Building and Running

### Prerequisites

- Ruby 3.3.5
- PostgreSQL 15
- Docker and Docker Compose (optional)

### Local Development (without Docker)

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Setup database:
   ```bash
   bin/rails db:create db:migrate db:seed
   ```

3. Start the server:
   ```bash
   bin/dev
   ```

4. Start background jobs worker (in separate terminal):
   ```bash
   bin/jobs start
   ```

### Docker Development

1. Create `.env` file with required environment variables:
   ```env
   POSTGRES_PASSWORD=your_password
   FLIGHT_FETCHER_KEY=your_rapidapi_key
   FLIGHT_FETCHER_HOST=aerodatabox.p.rapidapi.com
   ```

2. Start all services:
   ```bash
   docker-compose up
   ```

   This starts:
   - PostgreSQL database
   - Rails web server (port 3000)
   - Solid Queue worker

### Testing

Run the test suite:
```bash
bin/rails test
```

Tests are located in `test/` directory using Minitest, covering models and jobs.

### Code Quality

Run linters and security checks:
```bash
bin/rubocop
bin/brakeman
```

## Development Conventions

### Code Style

- Follows Rails Omakase style guide via `rubocop-rails-omakase`
- Uses standard Rails conventions and patterns

### Database

- All timestamps stored in UTC
- Geographic coordinates stored as floats
- Flight distances calculated using Haversine formula (in kilometers)
- Unique constraints on flight combinations (number + departure time + airline + airports)

### Internationalization

- Locale parameter in URLs: `/:locale/...`
- Available locales: `:en` (default), `:ru`
- Locale files in `config/locales/`

### Authentication

- Session-based authentication using `has_secure_password`
- Authentication concern included in controllers requiring login
- Session tracking with IP address and user agent

### Routes

- Root route: `/` → `flights#index`
- Locale-scoped routes: `/:locale/...`
- Key routes:
  - `/add` - Add new flight
  - `/search` - Search flights
  - `/map` - Flight map visualization
  - `/flight_stats`, `/airport_stats`, etc. - Statistics pages
  - `/rating` - User ratings

## Environment Variables

Required environment variables:
- `POSTGRES_PASSWORD` - PostgreSQL password
- `FLIGHT_FETCHER_KEY` - RapidAPI key for AeroDataBox
- `FLIGHT_FETCHER_HOST` - API host (aerodatabox.p.rapidapi.com)
- `DB_HOST` - Database host (default: localhost)
- `RAILS_MAX_THREADS` - Thread pool size (default: 5)

## Deployment

The application is configured for deployment with Kamal:
- Docker-based deployment
- Includes Thruster for HTTP asset caching
- Production configuration in `config/deploy.yml` (not present in repo)

## Key Files

- `config/routes.rb` - Route definitions
- `db/schema.rb` - Database schema
- `app/models/flight.rb` - Core flight logic and calculations
- `app/services/flights/flight_fetcher.rb` - External API integration
- `app/controllers/concerns/authentication.rb` - Authentication logic
- `docker-compose.yml` - Local development environment
