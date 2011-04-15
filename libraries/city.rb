before do
  unless session[:city_id] && session[:city_name]
    city = City.first(:short_name => 'sanjose')
    session[:city_id] = city.id
    session[:city_name] = city.name
  end
end


get '/cities/:short_name/?' do
  city = City.first(:short_name => params[:short_name])
  session[:city_id] = city.id
  session[:city_name] = city.name
  redirect request.referrer
end


class City  
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at

  property :name,       String, :required => true
  property :short_name, String, :required => true
  
  has n, :deals
  
end
