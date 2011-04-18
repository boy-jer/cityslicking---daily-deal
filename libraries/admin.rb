get '/admin/new/?' do
  erb :'admin/deal'
end

post '/admin/new/?' do
  # Create deal
  session[:flash] = 'Your deal has been created.'
  redirect "/deal/#{deal.id}"
end

get '/admin/:id/delete/?' do
  deal = Deal.get(params[:id])
  deal.destroy
  session[:flash] = 'Deal has been removed.'
  redirect '/admin'
end

get '/admin/:id/?' do
  @deal = Deal.get(params[:id])
  erb :'admin/deal'
end

post '/admin/:id/?' do
  deal = Deal.get(params[:id])
  # Save changes
  session[:flash] = 'Your deal has been updated.'
  redirect "/deal/#{params[:id]}"
end

get '/admin/?' do
  @deals = Deal.all
  erb :'admin/index'
end
