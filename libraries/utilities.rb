#
# Useful utilites used throughout the site
#


  get '/deals/?' do
    erb :'deals/featured'
  end

  get '/news/?' do
    erb :news
  end

  get '/about-us/?' do
    erb :about
  end

  get '/merchants/?' do
    erb :merchants
  end

  get '/profile/?' do
    erb :profile
  end

  get '/policies/?' do
    erb :policies
  end


# Helpers can be used anywhere in the site

  helpers do
  
  
  # Inserts p#flash containing session[:flash], provided it isn't nil
  # Then nils session[:flash] so it doesn't show up on the next request
  # Useful for user notifications
  # To use it, just set session[:flash] before rendering or redirecting
  
    def flash
      unless session[:flash].nil?
        msg = session[:flash]
        session[:flash] = nil
        "<p id='flash'>#{msg}</p>"
      end
    end
  
  
  # Adds a class of 'sticky' to an element
  
    def sticky(path)
      'class="sticky"' if request.path_info.include? "/#{path}"
    end
    
    
  # Used as inline html to hide elements
  # Useful alongside a conditional
  # Example: <img <%= hidden if x == y %> src="..." />

    def hidden
      'style="display: none;"'
    end
    
  
  # Formats text as Markdown
  
    def markdown(text)
      RDiscount.new(text).to_html
    end
    
    
  # Capitalizes the first letter of each word
    
    def titleize(string)
      title = '' 
      string.split(' ').each do |s|
        title << s.capitalize + ' '
      end
      title
    end
    
    
  # Converts an integer or a float into a '$' string
  # Example: dollarize(4.3) will return '$4.30'  
    
    def dollarize(num)
      num = "$%.2f" % num.to_f
    end
  
  
  # Formats an integer or a float
  # Leaves either 1 decimal, or none if the decimal is 0
  # Useful for weights and sizes
  
    def truncate_number(num)
      rounded = ''
      num = num.to_f
      if num > 0
        rounded = "%.1f" % num.to_f
        rounded = rounded.to_s.split('.').first if rounded.to_s.end_with?('0')
      end
      rounded
    end
  
    
  end


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
