get '/save/feature/:id/?' do
  @user = User.get(session[:user])

  @deal = Deal.get(params[:id])  
  @deal.display_percent = @deal.first_percent
  confirmations = Confirmation.all(:user_id => session[:user], :deal_id => params[:id])
  @deal.display_percent = @deal.return_percent if confirmations.count > 0
  
  deliver 'save/feature', :layout => false
end

get '/save/deal/:id/?' do
  @user = User.get(session[:user])

  @deal = Deal.get(params[:id])  
  @deal.display_percent = @deal.first_percent
  confirmations = Confirmation.all(:user_id => session[:user], :deal_id => params[:id])
  @deal.display_percent = @deal.return_percent if confirmations.count > 0

  deliver 'save/deal', :layout => false
end

get '/save/mobile/:id/?' do
  unless mobile_request?
    session[:flash] = 'Sorry, but you have to be using your smartphone to save with this deal.'
    redirect "/deals/#{params[:id]}"
  end
  @user = User.get(session[:user])

  @deal = Deal.get(params[:id])  
  @deal.display_percent = @deal.first_percent
  confirmations = Confirmation.all(:user_id => session[:user], :deal_id => params[:id])
  @deal.display_percent = @deal.return_percent if confirmations.count > 0

  deliver 'save/mobile'
end

post '/share/deal/:id/?' do
  params[:email].strip!
  params[:email] = 'deals@city-slicking.com' if params[:email] == ''
  Pony.mail(:via => :smtp, :via_options => settings.mail_server,
    :to      => params[:email],
    :subject => 'CitySlicking Deal',
    :body    => "You won't believe the deal I just got!  I'm dancing, I'm singing, I'm laughing out loud - well, at least I feel like it.  Anyway, I thought I'd share it with you too.  Check it out at http://city-slicking.com/deals/" + params[:id]
  )  
  session[:flash] = "Thanks for sharing."
  redirect "/deals/#{params[:id]}"
end

get '/save/gps/:id/?' do
  @user = User.get(session[:user])

  @deal = Deal.get(params[:id])  
  @deal.display_percent = @deal.first_percent
  confirmations = Confirmation.all(:user_id => session[:user], :deal_id => params[:id])
  @deal.display_percent = @deal.return_percent if confirmations.count > 0
  
  Confirmation.create(:user_id => session[:user], :deal_id => @deal.id, :method => 'gps', :expires => Chronic.parse('4 hours from now'))
  
  session[:flash] = "Present this confirmation code during checkout to receive #{@deal.display_percent} off: #{@deal.code}.<br />Good until #{format_day_with_time Chronic.parse('4 hours from now')}."
  redirect "/deals/#{@deal.id}"
end

get '/save/phone/:id/?' do
  @user = User.get(session[:user])

  @deal = Deal.get(params[:id])  
  @deal.display_percent = @deal.first_percent
  confirmations = Confirmation.all(:user_id => session[:user], :deal_id => params[:id])
  @deal.display_percent = @deal.return_percent if confirmations.count > 0

  Confirmation.create(:user_id => session[:user], :deal_id => @deal.id, :method => 'web', :expires => Chronic.parse('4 hours from now'))

  session[:flash] = "Present this confirmation code during checkout to receive #{@deal.display_percent} off: #{@deal.code}.<br />Good until #{format_day_with_time Chronic.parse('4 hours from now')}."
  redirect "/deals/#{@deal.id}"
end

get '/save/sms/:id/?' do
  @user = User.get(session[:user])

  @deal = Deal.get(params[:id])  
  @deal.display_percent = @deal.first_percent
  confirmations = Confirmation.all(:user_id => session[:user], :deal_id => params[:id])
  @deal.display_percent = @deal.return_percent if confirmations.count > 0

  Confirmation.create(:user_id => session[:user], :deal_id => @deal.id, :method => 'sms', :expires => Chronic.parse('24 hours from now'))

  account = Twilio::RestAccount.new(settings.sms_server[:account_sid], settings.sms_server[:account_token])
  msg = {
    'From' => settings.sms_server[:account_number],
    'To'   => @user.mobile,
    'Body' => "Present this confirmation code during checkout to receive #{@deal.display_percent} off: #{@deal.code}. Good until #{format_day_with_time Chronic.parse('24 hours from now')}."
  }
  account.request("/#{settings.sms_server[:api_version]}/Accounts/#{settings.sms_server[:account_sid]}/SMS/Messages", 'POST', msg)

  session[:flash] = "Check your phone! And don't forget to share this deals with your friends!"
  redirect "/deals/#{params[:id]}/?share=true"  
end


get '/admin/deals/report/:id/?' do
  auth_admin
  @deal = Deal.get(params[:id])
  deliver 'admin/deals/report'
end

post '/admin/deals/report/:id/?' do
  
  deal = Deal.get(params[:id])
  
  if params[:commit] == 'Save Invoice 1'
    deal.update(
      :date_sent_1        => Chronic.parse("#{params[:date_sent_1_year]}-#{params[:date_sent_1_month]}-#{params[:date_sent_1_day]}"),
      :amount_sent_1      => params[:amount_sent_1],
      :date_received_1    => Chronic.parse("#{params[:date_received_1_year]}-#{params[:date_received_1_month]}-#{params[:date_received_1_day]}"),
      :amount_received_1  => params[:amount_received_1],
      :salesman_1         => params[:salesman_1]
    )
  end

  if params[:commit] == 'Save Invoice 2'
    deal.update(
      :date_sent_2        => Chronic.parse("#{params[:date_sent_2_year]}-#{params[:date_sent_2_month]}-#{params[:date_sent_2_day]}"),
      :amount_sent_2      => params[:amount_sent_2],
      :date_received_2    => Chronic.parse("#{params[:date_received_2_year]}-#{params[:date_received_2_month]}-#{params[:date_received_2_day]}"),
      :amount_received_2  => params[:amount_received_2],
      :salesman_2         => params[:salesman_2]
    )
  end

  if params[:commit] == 'Save Invoice 3'
    deal.update(
      :date_sent_3        => Chronic.parse("#{params[:date_sent_3_year]}-#{params[:date_sent_3_month]}-#{params[:date_sent_3_day]}"),
      :amount_sent_3      => params[:amount_sent_3],
      :date_received_3    => Chronic.parse("#{params[:date_received_3_year]}-#{params[:date_received_3_month]}-#{params[:date_received_3_day]}"),
      :amount_received_3  => params[:amount_received_3],
      :salesman_3         => params[:salesman_3]
    )
  end

  if params[:commit] == 'Save Invoice 4'
    deal.update(
      :date_sent_4        => Chronic.parse("#{params[:date_sent_4_year]}-#{params[:date_sent_4_month]}-#{params[:date_sent_4_day]}"),
      :amount_sent_4      => params[:amount_sent_4],
      :date_received_4    => Chronic.parse("#{params[:date_received_4_year]}-#{params[:date_received_4_month]}-#{params[:date_received_4_day]}"),
      :amount_received_4  => params[:amount_received_4],
      :salesman_4         => params[:salesman_4]
    )
  end
  
  session[:flash] = 'Invoice updated.'
  redirect "/admin/deals/report/#{params[:id]}"
end


class Confirmation
  include DataMapper::Resource
  
  timestamps  :at
  property    :deleted_at,  ParanoidDateTime
  property    :id,          Serial
  
  property    :method,      String
  property    :expires,     DateTime
  
  belongs_to :user
  belongs_to :deal
  
end
