source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Postgresql for database
gem 'pg', '~> 0.18.4'
# Omniauth for OIDC authn
gem 'omniauth', '~> 1.9'
gem 'omniauth_openid_connect'
# Cancancan for permissions
gem 'cancancan', '~> 3.0', '>= 3.0.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # .env file for Omniauth tokens
  gem 'dotenv-rails', '~> 2.7', '>= 2.7.5'

  # Testing Stack
  gem 'rspec-rails', '~> 4.0.beta4'
  gem 'rails-controller-testing'
  gem 'factory_bot_rails', '~> 5.1'
  gem 'ffaker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
