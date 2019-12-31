# frozen_string_literal: true

#source 'https://rubygems.org'
source 'http://mirrors.aliyun.com/rubygems/'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg'
gem 'puma', '~> 3.11'
gem 'rails', '~> 6.0.0'
gem 'rapidfire'
gem 'sass-rails', '~> 5'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'
gem 'devise'
gem 'acts-as-taggable-on', '~> 6.0'

gem 'wechat'


group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # pry rails for dev console
  gem 'pry'
  gem 'pry-rails'

  # disable cors in development
  gem 'rack-cors'

  # profiler
  # gem 'rack-mini-profiler'

  # rails panel, https://github.com/dejan/rails_panel
  # gem 'meta_request'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end
