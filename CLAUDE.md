# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Rails 8.0.2+ application named LmsPrototype (Learning Management System Prototype) with:
- SQLite database (development and test environments)
- Tailwind CSS for styling
- Hotwire (Turbo and Stimulus) for frontend interactivity
- Solid Cache, Solid Queue, and Solid Cable for Rails.cache, Active Job, and Action Cable
- Kamal for Docker deployment
- Propshaft for asset pipeline

## Development Commands

### Setup and Running
- `bin/setup` - Initial setup (installs dependencies, prepares database, starts server)
- `bin/dev` - Start development server with Tailwind CSS watch (runs on port 3000 by default)
- `bin/rails server` - Start Rails server only
- `bin/rails console` - Open Rails console

### Database
- `bin/rails db:create` - Create database
- `bin/rails db:migrate` - Run migrations
- `bin/rails db:prepare` - Create and migrate database
- `bin/rails db:drop` - Drop database
- `bin/rails db:reset` - Drop, create, and migrate database
- `bin/rails db:seed` - Load seed data

### Testing
- `bin/rails test` - Run all tests
- `bin/rails test test/models/` - Run model tests
- `bin/rails test test/controllers/` - Run controller tests
- `bin/rails test:system` - Run system tests
- `bin/rails test test/path/to/specific_test.rb` - Run specific test file
- `bin/rails test test/path/to/specific_test.rb:LINE_NUMBER` - Run specific test

### Code Quality
- `bin/rubocop` - Run RuboCop linter (uses Omakase Ruby styling)
- `bin/rubocop -a` - Auto-correct RuboCop offenses
- `bin/brakeman` - Run security analysis

### Asset Management
- `bin/rails tailwindcss:build` - Build Tailwind CSS
- `bin/rails tailwindcss:watch` - Watch and rebuild Tailwind CSS on changes
- `bin/rails assets:precompile` - Compile all assets
- `bin/rails assets:clean` - Remove old compiled assets

### Deployment
- `bin/kamal setup` - Initial Kamal deployment setup
- `bin/kamal deploy` - Deploy with Kamal

## Architecture

### Directory Structure
- `app/` - Main application code
  - `controllers/` - Request handling logic
  - `models/` - Business logic and data persistence
  - `views/` - HTML templates (ERB)
  - `helpers/` - View helper methods
  - `jobs/` - Background job classes
  - `mailers/` - Email sending classes
  - `javascript/` - JavaScript files (Stimulus controllers, etc.)
  - `assets/` - Static assets and stylesheets

- `config/` - Application configuration
  - `routes.rb` - URL routing definitions
  - `database.yml` - Database configuration
  - `application.rb` - Main application configuration

- `db/` - Database files
  - `migrate/` - Database migrations
  - `schema.rb` - Current database schema

- `test/` - Test files organized by type

### Key Technologies
- **Frontend**: Importmap for JavaScript, Turbo for SPA-like navigation, Stimulus for JavaScript behavior, Tailwind CSS for styling
- **Database**: SQLite3 with separate databases for development, test, and production (including cache, queue, and cable databases in production)
- **Testing**: Minitest (Rails default), Capybara and Selenium for system tests
- **Background Jobs**: Solid Queue (database-backed)
- **Caching**: Solid Cache (database-backed)
- **WebSockets**: Solid Cable (database-backed)

### Development Workflow
1. Models inherit from `ApplicationRecord` (Active Record)
2. Controllers inherit from `ApplicationController`
3. Views use ERB templating with Turbo Frames/Streams for dynamic updates
4. Stimulus controllers handle JavaScript interactions
5. Tailwind CSS classes for styling (compiled via `bin/rails tailwindcss:watch`)
6. Routes defined in `config/routes.rb` following RESTful conventions