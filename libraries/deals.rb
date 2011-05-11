get '/home/?' do
  @deals = City.get(session[:city_id]).deals(:order => :publish_date.desc, :limit => 3, :active => true, :publish_date.lt => Chronic.parse('now'), :expiration_date.gt => Chronic.parse('now'))
  deliver 'home'
end

get '/deals/?' do
  if params[:find] && params[:find].length > 0
    @deals = Deal.search(session[:city_id], params[:find])
  else
    @deals = Deal.live(session[:city_id])
  end
  deliver 'deals'
end

get '/deals/:id/?' do
  @deal = Deal.get(params[:id])
  deliver 'deal'
end


get '/admin/?' do
  auth_admin
  redirect '/admin/deals'
end

get '/admin/deals/?' do
  auth_admin
  @deals = Deal.all(:order => :title)
  deliver 'admin/deals/index'
end

get '/admin/deals/new/?' do
  auth_admin
  deliver 'admin/deals/deal'
end

post '/admin/deals/new/?' do
  auth_admin
  deal = Deal.create(
    :title                  => params[:title],
    :merchant_id            => params[:merchant],
    :publish_date           => Chronic.parse("#{params[:publish_date_year]}-#{params[:publish_date_month]}-#{params[:publish_date_day]}"),
    :expiration_date        => Chronic.parse("#{params[:expiration_date_year]}-#{params[:expiration_date_month]}-#{params[:expiration_date_day]}"),
    :max_saves              => params[:max_saves],
    :max_returns            => params[:max_returns],
    :first_percent          => params[:first_percent],
    :return_percent         => params[:return_percent],
    :description            => params[:description],
    :code                   => params[:code],
    :legalese               => params[:legalese],
    :final_corrections_date => Chronic.parse("#{params[:final_corrections_date_year]}-#{params[:final_corrections_date_month]}-#{params[:final_corrections_date_day]}")
  )
  
  deal.save
  
  if params[:active]
    deal.active = true
    deal.date_activated = Chronic.parse('today')
    deal.save
  end
  
  if params[:preview_authorized_by].strip.length > 0
    deal.preview_authorized_by = params[:preview_authorized_by].strip
    deal.preview_authorized_date = Chronic.parse('today')
    deal.save
  end
  
  File.open("public/images/deals/#{deal.id}.jpg", 'wb') { |file| file.write(params[:pic][:tempfile].read) } if params[:pic]
  
  deal.locations.create(
    :street => params[:street1],
    :city   => params[:city1],
    :state  => params[:state1],
    :zip    => params[:zip1]
  ) if params[:street1].strip.length > 0
  
  deal.locations.create(
    :street => params[:street2],
    :city   => params[:city2],
    :state  => params[:state2],
    :zip    => params[:zip2]
  ) if params[:street2].strip.length > 0
  
  deal.locations.create(
    :street => params[:street3],
    :city   => params[:city3],
    :state  => params[:state3],
    :zip    => params[:zip3]
  ) if params[:street3].strip.length > 0
    
  params[:cities].each do |c|
    deal.city_deals.create(:city_id => c.first)
  end
  
  redirect "admin/deals/preview/#{deal.id}"
end

get '/admin/deals/edit/:id/?' do
  auth_admin
  @deal = Deal.get(params[:id])
  deliver 'admin/deals/deal'
end

post '/admin/deals/edit/:id/?' do
  auth_admin
  deal                        = Deal.get(params[:id])
  
  deal.title                  = params[:title]
  deal.merchant_id            = params[:merchant]
  deal.publish_date           = Chronic.parse("#{params[:publish_date_year]}-#{params[:publish_date_month]}-#{params[:publish_date_day]}")
  deal.expiration_date        = Chronic.parse("#{params[:expiration_date_year]}-#{params[:expiration_date_month]}-#{params[:expiration_date_day]}")
  deal.max_saves              = params[:max_saves]
  deal.max_returns            = params[:max_returns]
  deal.first_percent          = params[:first_percent]
  deal.return_percent         = params[:return_percent]
  deal.description            = params[:description]
  deal.code                   = params[:code]
  deal.legalese               = params[:legalese]
  deal.final_corrections_date = Chronic.parse("#{params[:final_corrections_date_year]}-#{params[:final_corrections_date_month]}-#{params[:final_corrections_date_day]}")
  
  params[:active] ? active = true : active = false
  if deal.active
    unless active
      deal.active = false
      deal.date_activated = nil
    end
  else
    if active
      deal.active = true
      deal.date_activated = Chronic.parse('today')
    end
  end
    
  if params[:preview_authorized_by].strip.length == 0
    deal.preview_authorized_by = nil
    deal.preview_authorized_date = nil
  else
    unless deal.preview_authorized_by == params[:preview_authorized_by]
      deal.preview_authorized_by = params[:preview_authorized_by].strip
      deal.preview_authorized_date = Chronic.parse('today')
    end
  end
  
  File.open("public/images/deals/#{deal.id}.jpg", 'wb') { |file| file.write(params[:pic][:tempfile].read) } if params[:pic]
  
  deal.locations.all.destroy
  
  deal.locations.create(
    :street => params[:street1],
    :city   => params[:city1],
    :state  => params[:state1],
    :zip    => params[:zip1]
  ) if params[:street1].strip.length > 0
  
  deal.locations.create(
    :street => params[:street2],
    :city   => params[:city2],
    :state  => params[:state2],
    :zip    => params[:zip2]
  ) if params[:street2].strip.length > 0
  
  deal.locations.create(
    :street => params[:street3],
    :city   => params[:city3],
    :state  => params[:state3],
    :zip    => params[:zip3]
  ) if params[:street3].strip.length > 0
  
  deal.save
  
  deal.city_deals.all.destroy
  
  params[:cities].each do |c|
    deal.city_deals.create(:city_id => c.first)
  end
      
  redirect "admin/deals/preview/#{deal.id}"
end

post '/deal-images/?' do
  # 49e5ff1f980d07ce77d9@cloudmailin.net
  mail = Mail.new(params[:mail])
  
  File.open("public/images/deals/#{mail.subject}.jpg", 'wb') {|f| f.write(mail.attachments.first.decoded) } if mail.attachments
end

get '/admin/deals/delete/:id/?' do
  auth_admin
  deal = Deal.get(params[:id])
  deal.destroy
  session[:flash] = 'Deal removed.'
  redirect '/admin/deals'
end

get '/admin/deals/preview/:id/?' do
  auth_admin
  @deal = Deal.get(params[:id])
  deliver 'admin/deals/preview'
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
  property  :final_corrections_date,  Date,     :default => Chronic.parse('1 month from now')
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
  
  has n, :confirmations
  has n, :users, :through => :confirmations
  
  def self.live(city)
    City.get(city).deals(:order => :expiration_date.asc, :active => true, :publish_date.lt => Chronic.parse('now'), :expiration_date.gt => Chronic.parse('now'))
  end
  
  def self.search(city, query)
    self.live(city).all(:title.like => "%#{query}%")
  end
  
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
