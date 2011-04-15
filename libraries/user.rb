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
