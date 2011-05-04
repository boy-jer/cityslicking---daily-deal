#
# Useful utilites used throughout the site
#


# Controls the app

  module App
    
    
  # Restarts the app on a Phusion Passenger server
  # Useful for 'hot reloading' during development
  
    def self.restart
      FileUtils.touch 'tmp/restart.txt'
    end
    
    
  end


# In-app logging

  module Logger
  
  
  # Will write a custom message to log/message.log
  # Useful for debugging

    def self.message(msg)
      File.open('log/messages.log', 'a+') { |f| f.write("\n#{msg}\n") }
    end
  
  
  # Writes only errors
  # Useful in production environments

    def self.write_errors(env, request)
      if env['sinatra.error']
        File.open("log/#{settings.environment}.log", 'a+') do |f|
          f.write("\n#{env['sinatra.error']}\n")
          f.write("  #{Time.now} #{env['SERVER_PROTOCOL']} #{request.port} #{request.request_method} #{request.url}\n\n")
        end
      end
    end
  
  
  # Writes both errors and request info
  # Useful in development environments

    def self.write_requests_and_errors(env, request)
      File.open("log/#{settings.environment}.log", 'a+') do |f|
        f.write("\n#{env['sinatra.error']}\n") if env['sinatra.error']
        f.write("  #{Time.now} #{env['SERVER_PROTOCOL']} #{request.port} #{request.request_method} #{request.url}\n")
        f.write("\n") if env['sinatra.error']
      end
    end
  
  
  # Empties all .log files in /log

    def self.clear(file)
      File.open("log/#{file}.log", 'w+') if File::exists?("log/#{file}.log")
    end
  
  
  end
