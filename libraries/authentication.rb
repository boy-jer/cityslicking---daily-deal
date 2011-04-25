#
# Authentication helpers can be used anywhere in the site
# Usually they'll be at the beginning of a method, or used as a before filter
#


  helpers do
    
    
  # User must be signed in
  
    def auth_slicker
      unless session[:user]
        session[:flash] = 'You must be signed in to see that page.'
        redirect '/home'
      end
    end
    
    
  # User must have admin privileges
    
    def auth_admin
      auth_slicker
      user = User.get(session[:user])
      unless user.admin?
        session[:flash] = 'You must be an admin to see that page.'
        redirect '/home'
      end
    end
    
    
  end
