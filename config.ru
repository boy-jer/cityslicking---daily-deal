#
# Main application, modeled on Sinatra and Rack
#


# Manage gems with Bundler (Gemfile and Gemfile.lock)

  require 'bundler'
  Bundler.require
  
  
# Include configurations

  require './config/settings'
  require './config/accounts'


# Include Ruby libraries

  Dir.glob File.dirname(__FILE__) + '/libraries/*.rb', &method(:require)
  

# Include database config

  require './config/databases'


# Run as a Sinatra application on a Rack server

  run Sinatra::Application
