get '/admin/resources/?' do
  auth_admin
  deliver 'admin/resources/resources'
end

get '/admin/resources/pricing-advantage/?' do
  auth_admin
  deliver 'admin/resources/pricing-advantage'
end

get '/admin/resources/blogger-agreement/?' do
  auth_admin
  deliver 'admin/resources/blogger-agreement'
end

post '/admin/resources/blogger-agreement/?' do
  auth_admin
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to        => 'johndickey@city-slicking.com',
    :subject   => 'CitySlicking Blogger Agreement',
    :html_body => erb(:'admin/resources/blogger-agreement_email', :layout => false)
  )
  session[:flash] = 'Check your inbox.'
  redirect '/admin/resources'
end

get '/admin/resources/merchants/10/?' do
  auth_admin
  deliver 'admin/resources/merchants/10'
end

post '/admin/resources/merchants/10/?' do
  auth_admin
  Agreement.create(
    :name   => params[:text6],
    :zip    => params[:text7],
    :social => params[:text8],
    :time   => Time.now
  )
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to        => 'johndickey@city-slicking.com',
    :cc        => 'mattcross@city-slicking.com',
    :bcc       => 'jarrodtaylor@city-slicking.com',
    :subject   => 'CitySlicking Merchant Agreement',
    :html_body => erb(:'admin/resources/merchants/10_email', :layout => false)
  )
  session[:flash] = 'Merchant agreement sent.'
  redirect '/admin/resources'
end

get '/admin/resources/merchants/100/?' do
  auth_admin
  deliver 'admin/resources/merchants/100'
end

post '/admin/resources/merchants/100/?' do
  auth_admin
  Agreement.create(
    :name   => params[:text6],
    :zip    => params[:text7],
    :social => params[:text8],
    :time   => Time.now
  )
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to        => 'johndickey@city-slicking.com',
    :cc        => 'mattcross@city-slicking.com',
    :bcc       => 'jarrodtaylor@city-slicking.com',
    :subject   => 'CitySlicking Merchant Agreement',
    :html_body => erb(:'admin/resources/merchants/100_email', :layout => false)
  )
  session[:flash] = 'Merchant agreement sent.'
  redirect '/admin/resources'
end

get '/admin/resources/merchants/200/?' do
  auth_admin
  deliver 'admin/resources/merchants/200'
end

post '/admin/resources/merchants/200/?' do
  auth_admin
  Agreement.create(
    :name   => params[:text6],
    :zip    => params[:text7],
    :social => params[:text8],
    :time   => Time.now
  )
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to        => 'johndickey@city-slicking.com',
    :cc        => 'mattcross@city-slicking.com',
    :bcc       => 'jarrodtaylor@city-slicking.com',
    :subject   => 'CitySlicking Merchant Agreement',
    :html_body => erb(:'admin/resources/merchants/200_email', :layout => false)
  )
  session[:flash] = 'Merchant agreement sent.'
  redirect '/admin/resources'
end

get '/admin/resources/merchants/300/?' do
  auth_admin
  deliver 'admin/resources/merchants/300'
end

post '/admin/resources/merchants/300/?' do
  auth_admin
  Agreement.create(
    :name   => params[:text6],
    :zip    => params[:text7],
    :social => params[:text8],
    :time   => Time.now
  )
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to        => 'johndickey@city-slicking.com',
    :cc        => 'mattcross@city-slicking.com',
    :bcc       => 'jarrodtaylor@city-slicking.com',
    :subject   => 'CitySlicking Merchant Agreement',
    :html_body => erb(:'admin/resources/merchants/300_email', :layout => false)
  )
  session[:flash] = 'Merchant agreement sent.'
  redirect '/admin/resources'
end

get '/admin/resources/merchants/free/?' do
  auth_admin
  deliver 'admin/resources/merchants/free'
end

post '/admin/resources/merchants/free/?' do
  auth_admin
  Agreement.create(
    :name   => params[:text6],
    :zip    => params[:text7],
    :social => params[:text8],
    :time   => Time.now
  )
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to        => 'johndickey@city-slicking.com',
    :cc        => 'mattcross@city-slicking.com',
    :bcc       => 'jarrodtaylor@city-slicking.com',
    :subject   => 'CitySlicking Merchant Agreement',
    :html_body => erb(:'admin/resources/merchants/free_email', :layout => false)
  )
  session[:flash] = 'Merchant agreement sent.'
  redirect '/admin/resources'
end