get '/admin/deal/new/?' do
  erb :'admin/deals/deal'
end

post '/admin/deal/new/?' do
  # Create deal
  session[:flash] = 'Your deal has been created.'
  redirect "/deal/#{deal.id}"
end

get '/admin/deal/:id/delete/?' do
  deal = Deal.get(params[:id])
  deal.destroy
  session[:flash] = 'Deal has been removed.'
  redirect '/admin/deal'
end

get '/admin/deal/:id/?' do
  @deal = Deal.get(params[:id])
  erb :'admin/deals/deal'
end

post '/admin/deal/:id/?' do
  deal = Deal.get(params[:id])
  # Save changes
  session[:flash] = 'Your deal has been updated.'
  redirect "/deal/#{params[:id]}"
end

get '/admin/deals/?' do
  @deals = Deal.all
  erb :'admin/deals/index'
end
