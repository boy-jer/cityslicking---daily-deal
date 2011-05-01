#
# Detects mobile devices based on user agents, then routes requests to the appropriate view
#


  helpers do
  
  # Checks user agents by matching string patterns against mobile_user_agent_patterns
  # Returns true if user agent matches

    def mobile_request?
      mobile_user_agent_patterns = [
        /iPhone/,
        /Android.*AppleWebKit/
      ]
      mobile_user_agent_patterns.any? {|r| request.env['HTTP_USER_AGENT'] =~ r}
    end
    
    
  # Returns a view file name with .mobile if it exists, otherwise returns the normal .html file name
    
    def mobile_file(file)
      File.exists?("#{settings.views}/#{file}#{@device}.html") ? view = "#{file}#{@device}" : view = file
    end
  
  
  # Replaces Sinatra's erb method
  # View path is a string instead of a symbol
  # To use :locals you must first provide a :layout (find a fix for this) [Is this still an issue?]
  
    def deliver(view, options = {:layout => 'layout', :locals => {}})      
      options[:layout] = 'layout' unless options[:layout] || options[:layout] == false
      options[:layout] == false ? layout = false : layout = mobile_file(options[:layout]).to_sym
      erb mobile_file(view).to_sym, :layout => layout, :locals => options[:locals]
    end
  
  
  end


# Sets @device based on mobile_request? (see above)
  
  before do
    mobile_request? ? @device = '.mobile' : @device = ''
  end
