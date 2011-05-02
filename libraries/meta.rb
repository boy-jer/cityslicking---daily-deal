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

get '/admin/resources/?' do
  auth_admin
  deliver 'admin/resources/resources'
end

get '/admin/resources/advertising-and-promotions-agreement/?' do
  auth_admin
  deliver 'admin/resources/advertising-and-promotions-agreement'
end
