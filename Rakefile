#
# Rake tasks
# Example: 'rake app:restart'
#


# Enables Utilities methods in rake tasks

  require './libraries/utilities'
  

# 'rake app:restart' will restart the app on a Phusion Passenger server
# Works on both Nginx and Apache

  namespace :app do
    desc 'Restarts the app on a Passenger server'
    task :restart do
      App.restart
    end
  end
  
  
# 'rake logs:clear' empties all the log files
# FYI: Logs shouldn't be included in the git repo

  namespace :logs do
    desc 'Clears log files'
    task :clear do
      Dir.glob(File.dirname(__FILE__) + '/log/*').each do |file|
        Logger.clear(file)
      end
    end
  end
  
  
# Handles data
  
  namespace :database do
    
    
  # Destructive
    
    desc 'Auto migrates the database'
    task :migrate do
      require 'bundler'
      Bundler.require
      Encoding.default_external = 'utf-8'
      Dir.glob File.dirname(__FILE__) + '/libraries/*.rb', &method(:require)
      DataMapper.finalize
      DataMapper.setup(:default, "sqlite://#{Dir.pwd}/data/development.sqlite3")
      DataMapper.auto_migrate!
    end
    
    
    desc 'Seeds the database'
    task :seed do
      require 'bundler'
      Bundler.require
      Encoding.default_external = 'utf-8'
      Dir.glob File.dirname(__FILE__) + '/libraries/*.rb', &method(:require)
      DataMapper.finalize
      DataMapper.setup(:default, "sqlite://#{Dir.pwd}/data/development.sqlite3")
      require "#{Dir.pwd}/data/seeds.rb"
    end
    
  end
