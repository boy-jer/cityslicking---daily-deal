get '/admin/resources/?' do
  auth_admin
  deliver 'admin/resources/resources'
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

get '/admin/resources/advertising-and-promotions-agreement/?' do
  auth_admin
  deliver 'admin/resources/advertising-and-promotions-agreement'
end

post '/admin/resources/advertising-and-promotions-agreement/?' do
  auth_admin
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to        => 'johndickey@city-slicking.com',
    :cc        => 'mattcross@city-slicking.com',
    :bcc       => 'jarrodtaylor@city-slicking.com',
    :subject   => 'CitySlicking Merchant Agreement',
    :html_body => erb(:'admin/resources/advertising-and-promotions-agreement_email', :layout => false)
  )
  session[:flash] = 'Check your inbox.'
  redirect '/admin/resources'
end
