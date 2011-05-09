get '/about-us/?' do
  deliver 'about'
end

get '/how-it-works/?' do
  deliver 'how-it-works'
end

get '/merchants/?' do
  deliver 'merchants'
end

get '/policies/?' do
  deliver 'policies'
end

get '/contact-us/?' do
  deliver 'contact'
end

post '/contact-us/?' do
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to => 'johndickey@city-slicking.com',
    :subject => 'Contact Form: ' + params[:subject],
    :body => params[:body]
  )
  session[:flash] = "Thanks, we'll be in touch."
  redirect '/contact-us'
end