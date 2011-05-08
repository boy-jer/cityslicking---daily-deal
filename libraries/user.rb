get '/sign-in/?' do
  deliver 'sign-in', :layout => false
end

post '/sign-in/?' do
  
  errors = 0
  msgs   = ''
  
  unless params[:tos]
    errors = errors + 1
    msgs << "You must agree to the Terms of Service to use this site.<br />"
  end
  
  params[:email].strip!
  params[:email].downcase!
  params[:password].strip!
  params[:password].downcase!
  
  if params[:account_type] == 'new'
    unless params[:email].length == 0 || params[:password].length == 0 || params[:zip].length == 0
      if user = User.first(:email => params[:email])
        errors = errors + 1
        msgs << "Email address is already in use. Try again.<br />"
      else
        user = User.new(:email => params[:email], :password => params[:password])
        if user.save
          Pony.mail(:via => :smtp, :via_options => settings.mail_server,
            :to => params[:email],
            :subject => 'Welcome to City Slicking',
            :body => 'Welcome to City Slicking. <instructions go here>'
          )
          session[:user] = user.id
        else
          errors = errors + 1
          msgs << "Registration error.<br />"
        end
      end
    else
      errors = errors + 1
      msgs << "You must provide an email address, password and zip code to register.<br />"
    end
  end
  
  if params[:account_type] == 'existing'
    if user = User.first(:email => params[:email], :password => params[:password])
      session[:user] = user.id
    else
      errors = errors + 1
      msgs << 'Email/password combo is incorrect. Try again.<br />'
    end
  end
  
  if errors > 0
    session[:flash] = msgs
    deliver 'sign-in', :layout => false
  else
    session[:flash] = 'Welcome to City Slicking!'
    '<script type="text/javascript" charset="utf-8">window.location = "/home"</script>'
  end
  
end

get '/sign-out/?' do
  session[:user] = nil
  session[:flash] = 'You are now signed out.'
  redirect '/home'
end

get '/profile/?' do
  @user = User.get(session[:user])
  @confirmations = @user.confirmations
  deliver 'profile'
end

post '/profile/?' do
  params[:email].strip!
  params[:email].downcase!
  params[:password].strip!
  params[:password].downcase!
  params[:zip].strip!
  params[:age].strip!
  
  if params[:email].length == 0 || params[:password].length == 0
    session[:flash] = 'You must provide both and email and a password to update.'
    redirect '/profile'
  end
  
  user = User.get(session[:user])
  
  unless params[:email] == user.email
    if User.all(:email => params[:email]).count > 0
      session[:flash] = 'Email address is already in use. Try again.'
      redirect '/profile'
    end
  end
  
  params[:gender] = 'unknown' unless params[:gender]
  
  user.update(
    :email    => params[:email],
    :password => params[:password],
    :zip      => params[:zip],
    :age      => params[:age],
    :gender   => params[:gender]
  )
  session[:flash] = 'Your account details have been updated.'
  redirect '/profile'
end

get '/subscribe/?' do
  auth_slicker
  user = User.get(session[:user])
  user.update(:subscriber => true)
  session[:flash] = 'You are now subscribed to the Daily Deals newsletter.'
  redirect request.referrer
end

get '/unsubscribe/?' do
  auth_slicker
  user = User.get(session[:user])
  user.update(:subscriber => false)
  session[:flash] = 'You have unsubscribed to the Daily Deals newsletter.'
  redirect request.referrer
end 

post '/verify/?' do
  mobile = Phoner::Phone.parse params[:mobile], :country_code => '1'
  user = User.get(session[:user])
  user.update(:mobile => mobile.format(:default))
  redirect '/profile'
end

get '/optedin/?' do
  user = User.get(session[:user])
  unless user.optin?
    mobile = User.get(session[:user]).mobile
    "<p><span style='background-color: lightyellow;'>Now text <strong>DEALS</strong> to <strong>(415) 599-2671</strong> from <em>#{Phoner::Phone.parse(mobile, :country_code => '1').format(:us)}</em> to finish the process.</span></p>"
  else
    "<script type='text/javascript' charset='utf-8'>window.location = '/profile';</script>"
  end
end

post '/sms/?' do
  params['Body'].strip!
  params['Body'].downcase!
  
  if params['Body'] == 'deals'
    if user = User.first(:mobile => params['From'])
      user.update(:optin => true, :optin_msg => params['Body'])
    end
  end
  
  if params['Body'] == 'stop'
    if user = User.first(:mobile => params['From'])
      user.update(:optin => false, :optin_msg => params['Body'])
    end
  end
end

get '/stop-sending-me-sms/?' do
  user = User.get(session[:user])
  user.update(:mobile => nil, :optin => false)
  redirect '/profile'
end


class User
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at
  
  property :email,      String
  property :password,   String
  property :mobile,     String
  property :age,        String
  property :gender,     String, :default => 'unknown'
  property :zip,        String
  
  property :optin,      Boolean, :default => false
  property :optin_msg,  String
  
  property :subscriber, Boolean, :default => false
  
  property :admin,      Boolean, :default => false
  
  has n, :confirmations
  has n, :deals, :through => :confirmations
  
end
