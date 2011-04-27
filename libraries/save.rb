get '/save/deal/:id/?' do
  @deal = Deal.get(params[:id])
  @user = User.get(session[:user])
  deliver 'deals/confirmation', :layout => false
end

post '/save/phone/:id/?' do
  @deal = Deal.get(params[:id])
  Confirmation.create(:user_id => session[:user], :deal_id => @deal.id, :method => 'web')
  "<p>#{@deal.code}</p>"
end

post '/save/email/:id/?' do
  @deal = Deal.get(params[:id])
  @user = User.get(session[:user])
  Confirmation.create(:user_id => session[:user], :deal_id => @deal.id, :method => 'email')
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to      => @user.email,
    :subject => 'CitySlicking Deal',
    :body    => "Present this confirmation code during checkout to receive the discount: #{@deal.code}"
  )
  "<p>Check your inbox!</p>"
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
  "<p>Check your phone!</p>"
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
