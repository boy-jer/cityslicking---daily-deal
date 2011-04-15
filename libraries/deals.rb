get '/deals/?' do
  erb :'deals/featured'
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
  
  belongs_to :dealer
  has n,     :locations
  has n,     :cities, :through => Resource
  
end


class Dealer
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at
  
  property :name, String
  
  has n, :deals
  
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
