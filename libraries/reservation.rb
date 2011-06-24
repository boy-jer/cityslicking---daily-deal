get '/reserve/:id/?' do
  Reservation.first_or_create(:user_id => session[:user], :deal_id => params[:id])
    
  user = User.get(session[:user])

  deal = Deal.get(params[:id])  
  deal.display_percent = deal.first_percent
  confirmations = Confirmation.all(:user_id => session[:user], :deal_id => params[:id])
  deal.display_percent = deal.return_percent if confirmations.count > 0

  Confirmation.create(:user_id => session[:user], :deal_id => deal.id, :method => 'email', :expires => Chronic.parse('24 hours from now'))
  
  deal.email_msg = "<h1 style='color: #800; margin-bottom: 0;'>#{deal.display_percent}% Off at #{deal.merchant.name}</h1><h2 style='margin-top: 7px;'>#{deal.title}</h2><p><a href='http://city-slicking.com/save/mobile/#{params[:id]}'>#{deal.title}</a></p>" + markdown(deal.email_msg)
  
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to      => user.email,
    :subject => 'CitySlicking Deal',
    :headers => { 'Content-Type' => 'text/html' },
    :body    => markdown(deal.email_msg) || ''
  )
  
  session[:flash] = "Thanks for reserving this deal, check your inbox. And don't forget to share this deals with your friends!"
  redirect "/deals/#{params[:id]}/?share=true"
end

class Reservation
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at
  
  belongs_to :deal
  belongs_to :user
  
end
