get '/admin/?' do
  auth_admin
  redirect '/admin/deals'
end

get '/admin/calendar/?' do
  auth_admin
  @features = Feature.all(:city_id	=> session[:city_id], :day.gte => Time.now)
  deliver 'admin/calendar'
end

post '/admin/features/?' do
	auth_admin
	Feature.first_or_create(
		:city_id => session[:city_id],
		:deal_id => params[:deal],
		:day		 => Chronic.parse("#{params[:day_year]}-#{params[:day_month]}-#{params[:day_day]}")
	)
	redirect '/admin/calendar'
end

get '/admin/features/:id/delete/?' do
	auth_admin
	f = Feature.get(params[:id])
	f.destroy
	redirect '/admin/calendar'
end

get '/admin/deals/?' do
  auth_admin
  admin?('admin') ? @deals = Deal.all(:order => :title) : @deals = Deal.all(:order => :title, :created_by => session[:user])
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
    :created_by             => params[:created_by],
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
    :neighborhood           => params[:neighborhood],
    :final_corrections_date => Chronic.parse("#{params[:final_corrections_date_year]}-#{params[:final_corrections_date_month]}-#{params[:final_corrections_date_day]}"),
    :email_msg              => params[:email_msg]
  )
  
  deal.save
  
  if params[:phone]
    deal.phone = true
    deal.save
  end
  
  if params[:sms]
    deal.sms = true
    deal.save
  end
  
  if params[:email]
    deal.email = true
    deal.save
  end
  
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
  
	File.open("public/images/deals/#{deal.id}_feature.jpg", 'wb') { |file| file.write(params[:feature_pic][:tempfile].read) } if params[:feature_pic]
	File.open("public/images/deals/#{deal.id}_details.jpg", 'wb') { |file| file.write(params[:details_pic][:tempfile].read) } if params[:details_pic]  
  
  if params[:street1].strip.length > 0
    street = params[:street1]
    city   = params[:city1]
    state  = params[:state1]
    zip    = params[:zip1]
    coords = Geocode.get_coords_from_addr(street, city, state)
    deal.locations.create(
      :street => street,
      :city   => city,
      :state  => state,
      :zip    => zip,
      :lat    => coords[:lat],
      :long   => coords[:long]
    )
  end
  
  if params[:street2].strip.length > 0
    street = params[:street2]
    city   = params[:city2]
    state  = params[:state2]
    zip    = params[:zip2]
    coords = Geocode.get_coords_from_addr(street, city, state)
    deal.locations.create(
      :street => street,
      :city   => city,
      :state  => state,
      :zip    => zip,
      :lat    => coords[:lat],
      :long   => coords[:long]
    )
  end
  
  if params[:street3].strip.length > 0
    street = params[:street3]
    city   = params[:city3]
    state  = params[:state3]
    zip    = params[:zip3]
    coords = Geocode.get_coords_from_addr(street, city, state)
    deal.locations.create(
      :street => street,
      :city   => city,
      :state  => state,
      :zip    => zip,
      :lat    => coords[:lat],
      :long   => coords[:long]
    )
  end
    
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
  deal.created_by             = params[:created_by]
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
  deal.neighborhood           = params[:neighborhood]
  deal.final_corrections_date = Chronic.parse("#{params[:final_corrections_date_year]}-#{params[:final_corrections_date_month]}-#{params[:final_corrections_date_day]}")
  deal.email_msg              = params[:email_msg]
  
  params[:phone] ? phone = true : phone = false
  if deal.phone
    deal.phone = false unless phone
  else
    deal.phone = true if phone
  end
  
  params[:sms] ? sms = true : sms = false
  if deal.sms
    deal.sms = false unless sms
  else
    deal.sms = true if sms
  end
  
  params[:email] ? email = true : email = false
  if deal.email
    deal.email = false unless email
  else
    deal.email = true if email
  end
  
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
  
  File.open("public/images/deals/#{deal.id}_feature.jpg", 'wb') { |file| file.write(params[:feature_pic][:tempfile].read) } if params[:feature_pic]
  File.open("public/images/deals/#{deal.id}_details.jpg", 'wb') { |file| file.write(params[:details_pic][:tempfile].read) } if params[:details_pic]  
  
  deal.locations.all.destroy
    
  if params[:street1].strip.length > 0
    street = params[:street1]
    city   = params[:city1]
    state  = params[:state1]
    zip    = params[:zip1]
    coords = Geocode.get_coords_from_addr(street, city, state)
    deal.locations.create(
      :street => street,
      :city   => city,
      :state  => state,
      :zip    => zip,
      :lat    => coords[:lat],
      :long   => coords[:long]
    )
  end
  
  if params[:street2].strip.length > 0
    street = params[:street2]
    city   = params[:city2]
    state  = params[:state2]
    zip    = params[:zip2]
    coords = Geocode.get_coords_from_addr(street, city, state)
    deal.locations.create(
      :street => street,
      :city   => city,
      :state  => state,
      :zip    => zip,
      :lat    => coords[:lat],
      :long   => coords[:long]
    )
  end
  
  if params[:street3].strip.length > 0
    street = params[:street3]
    city   = params[:city3]
    state  = params[:state3]
    zip    = params[:zip3]
    coords = Geocode.get_coords_from_addr(street, city, state)
    deal.locations.create(
      :street => street,
      :city   => city,
      :state  => state,
      :zip    => zip,
      :lat    => coords[:lat],
      :long   => coords[:long]
    )
  end
  
  deal.save
  
  if params[:cities]
    deal.city_deals.all.destroy
    params[:cities].each do |c|
      deal.city_deals.create(:city_id => c.first)
    end
  end
    
  redirect "admin/deals/preview/#{deal.id}"
end

post '/deal-images/?' do  
  # 49e5ff1f980d07ce77d9@cloudmailin.net
  mail = Mail.new(params[:message])
  File.open("public/images/deals/#{mail.subject}.jpg", 'wb') {|f| f.write(mail.body.decoded) }
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
  @deal.display_percent = @deal.first_percent
  deliver 'admin/deals/preview'
end