get '/admin/agreements/?' do
  auth_admin
  @agreements = Agreement.all(:approved_by => nil)
  @approved   = Agreement.all(:approved_by.not => nil)
  deliver 'admin/agreements'
end

get '/admin/agreements/approve/:id/?' do
  auth_admin
  agreement = Agreement.get(params[:id])
  user = User.get(session[:user])
  agreement.update(
    :approved_by => user.email,
    :approved_on => Time.now
  )
  session[:flash] = 'Agreement approved.'
  redirect '/admin/agreements/'
end

class Agreement  
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at

  property :name,         String
  property :zip,          String
  property :social,       String
  property :time,         String
  property :approved_by,  String
  property :approved_on,  Date
    
end
