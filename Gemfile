source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "action_args"
gem "bcrypt"
gem "bootstrap-sass"
gem "carrierwave"
gem "coffee-rails", "~> 4.2"
gem "dotenv-rails"
gem "faker"
gem "fog"
gem "haml", github: "haml"
gem "jbuilder", "~> 2.5"
gem "jpmobile"
gem "jquery-rails"
gem "kaminari"
gem "mini_magick"
gem "mysql2"
gem "omniauth"
gem "omniauth-twitter"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.2"
gem "redis"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "yoshida"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara"
  gem "factory_girl_rails"
  gem "guard-rspec", require: false
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.5"
  gem "rubocop", require: false
  gem "show_me_the_cookies"
  gem "sqlite3"
  gem "terminal-notifier-guard"
end

group :development do
  gem "brakeman", require: false
  gem "bullet"
  gem "erb2haml"
  gem "html2haml", github: "haml/html2haml"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "guard"
  gem "guard-minitest"
  gem "minitest-reporters"
  gem "rails-controller-testing"
  gem "turnip"
end

group :production do
  gem "pg"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
