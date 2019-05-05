source "https://rubygems.org"

gem 'sinatra'
gem 'activerecord', ">= 4.2.7.1", :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'shotgun'
gem 'bcrypt'
gem 'tux'
gem 'rack-flash3'

group :production do
	gem 'pg'
end

group :development, :test do
	gem 'pry'
	gem 'sqlite3'
end
