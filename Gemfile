source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.0.rc2"
gem "puma", "~> 3.7"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "mysql2"
gem "bootstrap-sass"
gem "bcrypt"
gem "haml", github: "haml"

group :development, :test do
  gem "sqlite3"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 3.5"
  gem "factory_girl_rails"
  gem "guard-rspec", require: false
  gem "terminal-notifier-guard"
  gem "capybara"
  gem "pry-rails"
  gem "show_me_the_cookies"
  gem "rubocop", require: false
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "erb2haml"
  gem "html2haml", github: "haml/html2haml"
end

group :test do
  gem "rails-controller-testing"
  gem "minitest-reporters"
  gem "guard"
  gem "guard-minitest"
end

group :production do
  gem "pg"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
