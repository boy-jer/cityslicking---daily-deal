get '/merchants/stats/?' do
  auth_merchant
  @merchant = Merchant.get(session[:merchant])
  deliver 'admin/merchant-stats'
end

get '/admin/merchants/?' do
  auth_admin
  @merchants = City.get(session[:city_id]).deals.merchants(:order => :name)
  @merchants = @merchants.all(:created_by => session[:user], :order => :name) if session[:user] == 29
  deliver 'admin/merchants/index'
end

get '/admin/merchants/new/?' do
  auth_admin
  deliver 'admin/merchants/merchant'
end

post '/admin/merchants/new/?' do
  auth_admin
  Merchant.create(
    :password         => params[:password],
    :created_by       => params[:created_by],
    :name             => params[:name],
    :owner            => params[:owner],
    :manager          => params[:manager],
    :email            => params[:email],
    :site             => params[:site],
    :type_of_business => params[:type_of_business],
    :phone1           => params[:phone1],
    :phone2           => params[:phone2],
    :phone3           => params[:phone3],
    :physical_street  => params[:physical_street],
    :physical_city    => params[:physical_city],
    :physical_state   => params[:physical_state],
    :physical_zip     => params[:physical_zip],
    :mailing_street   => params[:mailing_street],
    :mailing_city     => params[:mailing_city],
    :mailing_state    => params[:mailing_state],
    :mailing_zip      => params[:mailing_zip]
  )
  session[:flash] = 'Merchant created.'
  redirect '/admin/merchants'
end

get '/admin/merchants/edit/:id/?' do
  auth_admin
  @merchant = Merchant.get(params[:id])
  erb :'admin/merchants/merchant'
end

post '/admin/merchants/edit/:id/?' do
  auth_admin
  merchant = Merchant.get(params[:id])
  merchant.update(
    :password         => params[:password],
    :created_by       => params[:created_by],
    :name             => params[:name],
    :owner            => params[:owner],
    :manager          => params[:manager],
    :email            => params[:email],
    :site             => params[:site],
    :type_of_business => params[:type_of_business],
    :phone1           => params[:phone1],
    :phone2           => params[:phone2],
    :phone3           => params[:phone3],
    :physical_street  => params[:physical_street],
    :physical_city    => params[:physical_city],
    :physical_state   => params[:physical_state],
    :physical_zip     => params[:physical_zip],
    :mailing_street   => params[:mailing_street],
    :mailing_city     => params[:mailing_city],
    :mailing_state    => params[:mailing_state],
    :mailing_zip      => params[:mailing_zip]
  )
  session[:flash] = 'Merchant info saved.'
  redirect 'admin/merchants'
end

get '/admin/merchants/delete/:id/?' do
  auth_admin
  merchant = Merchant.get(params[:id])
  merchant.destroy
  session[:flash] = 'Merchant removed.'
  redirect '/admin/merchants'
end


class Merchant
  include DataMapper::Resource
  
  property    :id,                Serial
  property    :deleted_at,        ParanoidDateTime
  timestamps  :at
  
  property    :password,          String
  
  property    :created_by,        Integer, :default => 1
  
  property    :name,              String
  property    :owner,             String
  property    :manager,           String
  property    :email,             String
  property    :site,              String
  property    :type_of_business,  String
  property    :phone1,            String
  property    :phone2,            String
  property    :phone3,            String
  
  property    :physical_street,   String
  property    :physical_city,     String
  property    :physical_state,    String
  property    :physical_zip,      String

  property    :mailing_street,    String
  property    :mailing_city,      String
  property    :mailing_state,     String
  property    :mailing_zip,       String
  
  has n, :deals
  
  #def self.has_deals_in(city)
	#	City.get(city).deals.
	#end
  
end
