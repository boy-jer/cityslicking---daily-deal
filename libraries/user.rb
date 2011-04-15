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
  erb :profile
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
