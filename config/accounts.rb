# Gmail account details

  set :mail_server, {
    :user_name            => 'deals@city-slicking.com',
    :password             => 'cityslicking',
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :authentication       => :plain
  }


# Twilio account details

  set :sms_server, {
    :api_version    => '2010-04-01',
    :account_sid    => 'AC4bc98d6997314ab8d91032c67fe27da1',
    :account_token  => 'a0c7d8d9ae044015c5c68c0d5f501d2a',
    :account_number => '4085145609' # '4155992671'
  }
