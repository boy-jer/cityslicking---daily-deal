get '/save/deal/:id/?' do
  @deal = Deal.get(params[:id])
  @user = User.get(session[:user])
  deliver 'confirmation', :layout => false
end

get '/share/deal/:id/?' do
  deliver 'share', :layout => false
end

post '/share/deal/:id/?' do
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to      => params[:email],
    :subject => 'CitySlicking Deal',
    :body    => "Check out this new deal on City-Slicking: http://city-slicking.com/deals/" + params[:id]
  )  
  session[:flash] = "Thanks for sharing."
  '<script type="text/javascript" charset="utf-8">window.location = "/deals/' + params[:id] + '"</script>'
end

post '/save/phone/:id/?' do
  @deal = Deal.get(params[:id])
  Confirmation.create(:user_id => session[:user], :deal_id => @deal.id, :method => 'web')
  session[:flash] = "Present this confirmation code during checkout to receive the discount: #{@deal.code}"
  deliver 'share', :layout => false
end

post '/save/email/:id/?' do
  @deal = Deal.get(params[:id])
  @user = User.get(session[:user])
  Confirmation.create(:user_id => session[:user], :deal_id => @deal.id, :method => 'email')
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to      => @user.email,
    :subject => 'CitySlicking Deal',
    :body    =>
"#{@deal.code}

Congratulations, Slicker!  Here's your special deal code.  Be sure to check out the deal so you know the when's and where's and if there's any instructions.  Basically, just show this code to the merchant and enjoy!"
  )
  session[:flash] = "<p>Check your inbox!</p>"
  deliver 'share', :layout => false
end

post '/save/sms/:id/?' do
  @deal = Deal.get(params[:id])
  @user = User.get(session[:user])
  Confirmation.create(:user_id => session[:user], :deal_id => @deal.id, :method => 'sms')
  account = Twilio::RestAccount.new(settings.sms_server[:account_sid], settings.sms_server[:account_token])
  msg = {
    'From' => settings.sms_server[:account_number],
    'To'   => @user.mobile,
    'Body' => "Present this confirmation code during checkout to receive the discount: #{@deal.code}"
  }
  account.request("/#{settings.sms_server[:api_version]}/Accounts/#{settings.sms_server[:account_sid]}/SMS/Messages", 'POST', msg)
  session[:flash] = "Check your phone!"
  deliver 'share', :layout => false
end


get '/admin/deals/uses/:id/?' do
  auth_admin
  @deal = Deal.get(params[:id])
  deliver 'admin/deals/uses'
end


class Confirmation
  include DataMapper::Resource
  
  timestamps  :at
  property    :deleted_at,  ParanoidDateTime
  property    :id,          Serial
  
  property    :method,      String
  
  belongs_to :user
  belongs_to :deal
  
end
