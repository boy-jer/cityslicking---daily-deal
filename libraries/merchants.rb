class Merchant
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at
  
  property  :name,              String
  property  :owner,             String
  property  :manager,           String
  property  :email,             String
  property  :site,              String
  property  :type_of_business,  String
  property  :phone1,            String
  property  :phone2,            String
  property  :phone3,            String
  
  property :physical_street, String
  property :physical_city,   String
  property :physical_state,  String
  property :physical_zip,    String

  property :mailing_street, String
  property :mailing_city,   String
  property :mailing_state,  String
  property :mailing_zip,    String
  
  has n, :deals
  
end
