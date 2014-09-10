source 'https://rubygems.org'
source 'https://rails-assets.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
gem 'sass-rails', '~> 4.0.3'
# gem 'bootstrap-sass', '~> 2.3.2.1'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
# gem 'turbolinks'

gem 'jquery-ui-rails'
gem 'jbuilder', '~> 2.0'
# gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'devise'
gem 'cancancan', '~> 1.8'
gem 'rolify'
gem 'haml-rails'
gem 'pg'
gem 'formtastic'
gem 'activeadmin', github: 'gregbell/active_admin'

gem 'rails-assets-angular'
gem 'rails-assets-angular-sanitize'
gem 'rails-assets-angular-ui-router'
gem 'rails-assets-angular-route'
gem 'rails-assets-angular-animate'
gem 'rails-assets-angular-resource'
gem 'rails-assets-angulartics'
gem 'rails-assets-angular-bootstrap'
# gem 'angular-ui-bootstrap-rails'
gem 'font-awesome-sass'

gem 'acts_as_list'  # sortable gem

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
# gem 'spring',        group: :development

# Use unicorn as the app server
# group :production do
#   gem 'unicorn'
# end

group :development do
  gem 'capistrano', '~> 2.15.5'
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
  gem 'quiet_assets'
  gem 'sqlite3'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'faker'
  gem 'seedbank', github: 'james2m/seedbank'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
end

gem 'rails_12factor', group: :production

ruby "2.1.2"