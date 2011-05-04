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
    :account_sid    => 'AC4bc98d6997314ab8d91032c67fe27da1',
    :account_token  => 'a0c7d8d9ae044015c5c68c0d5f501d2a',
    :account_number => '4155992671'
  }


# Include Ruby libraries

  Dir.glob File.dirname(__FILE__) + '/libraries/*.rb', &method(:require)
  
  
# Finalize data models and connect to database

  DataMapper.finalize
  DataMapper.setup(:default, "sqlite://#{Dir.pwd}/data/development.sqlite3")
      

# Set root path
    
  get '/?' do
    redirect '/home'
  end


# Run as a Sinatra application on a Rack server

  run Sinatra::Application
