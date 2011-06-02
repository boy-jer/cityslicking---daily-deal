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
  
    def auth_admin(type = 'any')
      auth_slicker
      user = User.get(session[:user])
      if type == 'any'
        unless user.admin? || user.salesman? || user.writer?
          session[:flash] = 'You must be an admin to see that page.'
          redirect '/home'
        end
      elsif type == 'admin'
        unless user.admin?
          session[:flash] = 'You must be an admin to see that page.'
          redirect '/home'
        end
      elsif type == 'salesman'
        unless user.salesman?
          session[:flash] = 'You must be a salesman to see that page.'
          redirect '/home'
        end
      elsif type == 'writer'
        unless user.writer?
          session[:flash] = 'You must be a writer to see that page.'
          redirect '/home'
        end
      end
    end
    
    def admin?(type = 'any')
      auth_slicker
      user = User.get(session[:user])
      if type == 'any'
        user.admin? || user.salesman? || user.writer? ? true : false
      elsif type == 'admin'
        user.admin? ? true : false
      elsif type == 'salesman'
        user.salesman? ? true : false
      elsif type == 'writer'
        user.writer? ? true : false
      end
    end
        
    
  # Must be a merchant
  
    def auth_merchant
      unless session[:merchant]
        session[:flash] = 'You must be signed in as a merchant to see that page.'
        redirect '/home'
      end
    end
    
    
  end
