#
# Main application, modeled on Sinatra and Rack
#


# Manage gems with Bundler (Gemfile and Gemfile.lock)

  require 'bundler'
  Bundler.require


# Enable sessions

  set :sessions, true


# Render .html with embedded Ruby
  
  Tilt.register :html, Tilt[:erb]


# Include Ruby libraries

  Dir.glob File.dirname(__FILE__) + '/libraries/*.rb', &method(:require)
  
  
# Finalize data models and connect to database

  DataMapper.finalize
  DataMapper.setup(:default, "sqlite://#{Dir.pwd}/data/development.sqlite3")
  
  
# Auto migrate the database and enter seed data

  DataMapper.auto_migrate!
  require "#{Dir.pwd}/data/seeds.rb"
    

# Set root path
    
  get '/?' do
    redirect '/deals'
  end


# Run as a Sinatra application on a Rack server

  run Sinatra::Application
