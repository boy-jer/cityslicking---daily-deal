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
  
  if params[:street1].strip.length > 0
    deal.locations.create(
      :street => params[:street1],
      :city   => params[:city1],
      :state  => params[:state1],
      :zip    => params[:zip1]
    )
  end
  if params[:street2].strip.length > 0
    deal.locations.create(
      :street => params[:street2],
      :city   => params[:city2],
      :state  => params[:state2],
      :zip    => params[:zip2]
    )
  end
  if params[:street3].strip.length > 0
    deal.locations.create(
      :street => params[:street3],
      :city   => params[:city3],
      :state  => params[:state3],
      :zip    => params[:zip3]
    )
  end
  
  redirect "admin/deals/preview/#{deal.id}"
end

get '/admin/deals/edit/:id/?' do
  @deal = Deal.get(params[:id])
  erb :'admin/deals/deal'
end

post '/admin/deals/edit/:id/?' do
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
  
  if params[:street1].strip.length > 0
    deal.locations.create(
      :street => params[:street1],
      :city   => params[:city1],
      :state  => params[:state1],
      :zip    => params[:zip1]
    )
  end
  if params[:street2].strip.length > 0
    deal.locations.create(
      :street => params[:street2],
      :city   => params[:city2],
      :state  => params[:state2],
      :zip    => params[:zip2]
    )
  end
  if params[:street3].strip.length > 0
    deal.locations.create(
      :street => params[:street3],
      :city   => params[:city3],
      :state  => params[:state3],
      :zip    => params[:zip3]
    )
  end
    
  deal.save
  redirect "admin/deals/preview/#{deal.id}"
end

get '/admin/deals/delete/:id/?' do
  deal = Deal.get(params[:id])
  deal.destroy
  session[:flash] = 'Deal removed.'
  redirect '/admin/deals'
end

get '/admin/deals/preview/:id/?' do
  @deal = Deal.get(params[:id])
  erb :'admin/deals/preview'
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
