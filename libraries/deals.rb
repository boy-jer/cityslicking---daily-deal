get '/home/?' do
  @deals = City.get(session[:city_id]).deals(:order => :publish_date.desc, :limit => 3)
  erb :home
end

get '/deals/?' do
  @deals = City.get(session[:city_id]).deals
  erb :'deals/index'
end

get '/deals/:id/use' do
  @deal = Deal.get(params[:id])
  erb :'deals/use', :layout => false
end

get '/deals/:id/?' do
  @deal = Deal.get(params[:id])
  erb :'deals/info'
end


class Deal
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at
  
  property :title,            Text
  property :active,           Boolean, :default => false
  property :publish_date,     Date
  property :expiration_date,  Date
  property :legalese,         Text
  property :description,      Text
  property :code,             String
  property :max_saves,        Integer
  property :first_percent,    Integer
  property :return_percent,   Integer
  property :max_returns,      Integer
  
  belongs_to :merchant
  has n,     :locations
  has n,     :cities, :through => Resource
  
end


class Location
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at
  
  property :street, String
  property :city,   String
  property :state,  String
  property :zip,    String
  
  belongs_to :deal
  
end
