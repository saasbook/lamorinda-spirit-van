## Lamorinda Spirit Van — Copilot / AI Agent Instructions

Aim: make AI coding agents immediately productive by surfacing project structure, key workflows, and concrete examples.

- Project type: Ruby on Rails 7 app (Ruby 3.4.1). See `Gemfile` and `.ruby-version`.
- Local DB: `sqlite3` (development/test). Production: `pg` (Heroku). See `Gemfile` and `config/database.yml`.

Quick commands (what CI runs):

- Set up dev environment: `bin/setup` (installs gems, runs `bin/rails db:prepare`, clears logs/tmp).
- Install dependencies: `gem install bundler; bundle install`.
- Prepare DB: `bin/rails db:prepare` or `bundle exec rake db:create db:migrate`.
- Run Rails server: `bin/rails server` (or `bin/rails restart` after setup).
- Run unit tests: `bundle exec rspec`.
- Run feature tests: `bundle exec cucumber` (requires Chrome + chromedriver for CI/local headful tests).
- Security/static scans: `bin/brakeman` and `bin/importmap audit` (CI uses these).
- Linting: project includes RuboCop configured in CI.

Architecture & major patterns (important to know):

- Auth & roles: Devise + omniauth (Microsoft Entra). See `app/models/user.rb` (User::ROLES = ["admin","dispatcher","driver"]) and `app/controllers/users/omniauth_callbacks_controller.rb`.
  - `ApplicationController` enforces `before_action :authenticate_user!` and checks `role` (signs out users with blank roles). See `app/controllers/application_controller.rb`.
  - After sign-in users are routed to `role_home_path` (see `app/helpers/application_helper.rb`).

- Root & access boundaries:
  - Root: `drivers#index` (see `config/routes.rb`).
  - Blazer (data reporting) is mounted at `/blazer` and is restricted to `admin` or `dispatcher` users (see `config/routes.rb`).
  - Health check endpoint: `GET /up` => `rails/health#show` — used by load balancers/monitors.

- Rides & linked-ride model: the app models multi-stop rides as a linked list of `Ride` records.
  - Key code: `app/models/ride.rb` implements `build_linked_rides`, `get_all_linked_rides`, `extract_attrs_from_params`.
  - Controllers (e.g., `app/controllers/rides_controller.rb`) call `Ride.build_linked_rides` and feed `gon` for client-side autocomplete.

- Server-driven JS (Importmap + Stimulus) and Gon usage:
  - This project uses importmap (no Node bundling). Configure imports in `config/importmap.rb` and JS entry `app/javascript/application.js`.
  - Stimulus controllers live under `app/javascript/controllers`. Other JS files: `app/javascript/autocomplete.js`, `app/javascript/add_stop.js`, `app/javascript/datatables.js`.
  - Controllers frequently set `gon.*` variables (server -> client) — see `app/controllers/rides_controller.rb` and `app/javascript/autocomplete.js` which reads `gon.passengers` / `gon.addresses` / `gon.drivers`.

- Addresses normalization: `Ride#start_address_attributes=` and `#dest_address_attributes=` normalize and find-or-create addresses (avoid duplications). See `app/models/ride.rb` for normalization rules (titleize street/city, compact phone).

Conventions & repo patterns to follow (not generic advice):

- Use `bin/setup` for full dev setup.
- Tests: CI runs both RSpec and Cucumber; aim to keep feature tests working with headful Chrome. Local developers will need Chrome + chromedriver when running Cucumber. CI chooses chromedriver matching installed Chrome version.
- Avoid introducing frontend build tools — prefer Importmap and Stimulus unless adding a deliberate front-end step.
- Use `Ride.extract_attrs_from_params` + `Ride.build_linked_rides` when changing ride creation/update flows — this preserves the linked-list stop model.
- Follow existing role checks: use `require_role(...)` or `before_action -> { require_role("admin","dispatcher") }` for controller actions that should be limited.

Integration & creds notes (what to expect):

- Omniauth (Entra ID / Microsoft) requires environment credentials for OAuth; local devs usually fallback to database-auth unless configured. See `Gemfile` and `app/controllers/users/omniauth_callbacks_controller.rb`.
- CI (See `.github/workflows/ci.yml`):
  - Installs Ruby per `.ruby-version`, runs `bundle install`, prepares DB, installs Chrome + chromedriver, runs `rspec` and `cucumber`, and uploads coverage.
  - If you modify test infra or add browser specs, mirror the CI chromedriver selection logic (it matches chromedriver to installed Chrome version).

Where to look for examples when editing:

- Role and redirect patterns: `app/controllers/application_controller.rb`, `app/helpers/application_helper.rb`, `app/models/user.rb`.
- Linked-ride logic and examples of safely rebuilding ride chains: `app/models/ride.rb` and `app/controllers/rides_controller.rb`.
- JS server->client data flow: `app/controllers/rides_controller.rb` (sets `gon`) -> `app/javascript/autocomplete.js` and `app/javascript/add_stop.js` (consume `gon`).
- Dev/test setup scripts: `bin/setup`, `bin/rails`, `.github/workflows/ci.yml` (CI reference).

If unsure, preserve these invariants when changing code:

- Don't break the linked-ride chaining logic (use provided helpers).
- Keep role checks and Blazer mount access intact.
- When adding browser tests, ensure chromedriver compatibility or document required local setup.

If anything in this file is unclear or you want more detail (e.g., local chromedriver install steps, sample `.env` keys for Omniauth, or more code pointers), tell me which section to expand.
