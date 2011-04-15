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
