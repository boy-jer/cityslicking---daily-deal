class City  
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at

  property :name,       String, :required => true
  property :short_name, String, :required => true
  
end
