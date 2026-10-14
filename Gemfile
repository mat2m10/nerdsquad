source 'https://rubygems.org'

ruby file: '.ruby-version'

gem 'rails', '~> 8.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5'
# full-text search on games
gem 'pg_search'
# Use Puma as the app server
gem 'puma', '>= 6.0'
# Asset pipeline for the SCSS (Font Awesome via Sprockets; Bootstrap 4.6.2 SCSS is
# vendored in vendor/stylesheets so no Node/JS runtime is needed)
gem 'sprockets-rails'
gem 'sassc-rails'
gem 'font-awesome-sass', '~> 5.15'
# JavaScript via import maps (replaces Webpacker 4, no Node build step)
gem 'importmap-rails'
# Turbolinks makes navigating your web application faster
gem 'turbolinks', '~> 5'
gem 'turbolinks_render'
# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'devise'
gem 'simple_form'
gem 'cloudinary', '~> 2.0'
gem 'faker'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'dotenv-rails'
  gem 'brakeman', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console'
end
