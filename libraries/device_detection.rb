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
  
  
  # Replaces Sinatra's erb method
  # View path is a string instead of a symbol
  # To use :locals you must first provide a :layout (find a fix for this)
  
    def deliver(view, options = {:layout => 'layout', :locals => {}})
      options[:layout] == false ? layout = false : layout = :"#{@device}/#{options[:layout]}"
      erb :"#{@device}/#{view}", :layout => layout, :locals => options[:locals]
    end
  
  
  end


# Sets @device based on mobile_request? (see above)
  
  before do
    mobile_request? ? @device = 'mobile' : @device = 'desktop'
  end
