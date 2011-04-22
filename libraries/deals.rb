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


get '/admin/?' do
  redirect '/admin/deals'
end

get '/admin/deals/?' do
  @deals = Deal.all(:order => :title)
  erb :'admin/deals/index'
end

get '/admin/deals/new/?' do
  erb :'admin/deals/deal'
end

post '/admin/deals/new/?' do
  Deal.create(
  )
  session[:flash] = 'Deal created.'
  redirect '/admin/deals'
end

get '/admin/deals/edit/:id/?' do
  @deal = Deal.get(params[:id])
  erb :'admin/deals/deal'
end

post '/admin/deals/edit/:id/?' do
  deal = Deal.get(params[:id])
  deal.update(
  )
  session[:flash] = 'Deal info saved.'
  redirect 'admin/deals'
end

get '/admin/deals/delete/:id/?' do
  deal = Deal.get(params[:id])
  deal.destroy
  session[:flash] = 'Deal removed.'
  redirect '/admin/deals'
end


class Deal
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at
  
  property  :title,                   Text
  property  :active,                  Boolean,  :default => false
  property  :date_activated,          Date
  property  :preview_authorized_by,   String
  property  :preview_authorized_date, Date
  property  :final_corrections_date,  Date
  property  :publish_date,            Date,     :default => Chronic.parse('now')
  property  :expiration_date,         Date,     :default => Chronic.parse('3 months from now')
  property  :legalese,                Text
  property  :description,             Text
  property  :code,                    String
  property  :max_saves,               Integer,  :default => 10000
  property  :first_percent,           Integer,  :default => 50
  property  :return_percent,          Integer,  :default => 25
  property  :max_returns,             Integer,  :default => 5
  
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
