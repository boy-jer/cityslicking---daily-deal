get '/sign-in/?' do
  erb :'sign-in'
end

post '/sign-in/?' do
  params[:email].strip!
  params[:email].downcase!
  params[:password].strip!
  params[:password].downcase!
  
  if user = User.first(:email => params[:email], :password => params[:password])
    session[:user] = user.id
    redirect '/deals'
  else
    session[:flash] = 'Email/password combo is incorrect. Try again.'
    redirect '/sign-in'
  end
end

get '/sign-out/?' do
  session[:user] = nil
  redirect '/deals'
end

get '/profile/?' do
  @user = User.get(session[:user])
  erb :profile
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
    headers 'Content-Type' => "text/javascript"
    "window.location = '/profile';"
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
  user.update(:optin => false)
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
  
end
