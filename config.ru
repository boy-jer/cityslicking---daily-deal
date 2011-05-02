#
# Main application, modeled on Sinatra and Rack
#


# Manage gems with Bundler (Gemfile and Gemfile.lock)

  require 'bundler'
  Bundler.require
  
  
# Set the default encoding (also works around a bug in Rack)
  Encoding.default_external = 'utf-8'


# Enable sessions

  set :sessions, true


# Render .html with embedded Ruby
  
  Tilt.register :html, Tilt[:erb]
  

# Gmail account details

  set :mail_server, {
    :user_name            => 'deals@city-slicking.com',
    :password             => 'cityslicking',
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :authentication       => :plain
  }


# Twilio account details

  set :sms_server, {
    :api_version    => '2010-04-01',
    :account_sid    => 'AC6cf085ad788087be75edde742ceebeb1',
    :account_token  => 'dec6134f83eaa4bc58b407c84cf6245e',
    :account_number => '4155992671'
  }


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
    redirect '/home'
  end


# Run as a Sinatra application on a Rack server

  run Sinatra::Application
