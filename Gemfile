# This file is used by the bundler gem to know which gems are needed for this Rails project.

# You can install or update the gems by running 'bundle install' or simply 'bundle' in your terminal in the root of the project.

# You dont need to use 'require rails' or use 'require' for any other gem defined in this Gemfile because bundler is going to automatically require all the gems defined in this file (Gemfile).

# Once you run 'bundle' or 'bundle install', byndler will automatically update the 'Gemfile.lock' file. The 'Gemfile.lock' will 'lock' the gem to a specific version.
# This is important so that all the developers working on the project end up using the same exact Ruby version for this project.
# You should never modify 'Gemfile.lock' directly unless there is a Git conflict in it **

# If you have the Gem installed in your Ruby it will just be used, otherwise bundler will install that gem for you.

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'cowsay', '~> 0.3'

gem 'colorize', '~> 0.8.1'

gem 'faker', github: 'stympy/faker'

gem 'cancancan', '~> 1.10'

gem 'bootstrap-sass', '~> 3.3.6'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end


group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'interactive_editor'
  gem 'awesome_print'
  gem 'hirb'
  gem 'rails-erd'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
