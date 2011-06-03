post '/reserve/:id/?' do
  Reservation.first_or_create(:user_id => session[:user], :deal_id => params[:id])
  
  user = User.get(session[:user])
  deal = Deal.get(params[:id])
  
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to      => user.email,
    :subject => 'CitySlicking Deal',
    :headers => { 'Content-Type' => 'text/html' },
    :body    => "<p>Congratulations, Slicker!  We've reserved this deal for you to use later.  Be sure to check out the deal so you know the when's and where's and if there's any instructions.  When you're ready, just follow this link:</p><p><a href='http://city-slicking.com/deals/#{params[:id]}'>#{deal.title}</a></p><p>Not valid if printed.</p>"
  )
  
  session[:flash] = "<p>Thanks for reserving this deal. Check your inbox!</p>"
  deliver 'share', :layout => false
end

class Reservation
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at
  
  belongs_to :deal
  belongs_to :user
  
end
