module Fixture
  def self.load(file)
    contents = ''
    File.open("./data/fixtures/#{file}").each_line { |line| contents << line }
    contents
  end
end


san_jose   = City.create(:name => 'San Jose, CA',   :short_name => 'sanjose'   )
modesto    = City.create(:name => 'Modesto, CA',    :short_name => 'modesto'   )
stockton   = City.create(:name => 'Stockton, CA',   :short_name => 'stockton'  )
lodi       = City.create(:name => 'Lodi, CA',       :short_name => 'lodi'      )
elk_grove  = City.create(:name => 'Elk Grove, CA',  :short_name => 'elkgrove'  )
turlock    = City.create(:name => 'Turlock, CA',    :short_name => 'turlock'   )
sacramento = City.create(:name => 'Sacramento, CA', :short_name => 'sacramento')


admin        = User.create(:email => 'admin@city-slicking.com',        :password => 'cityslicking', :admin => true)
jarrodtaylor = User.create(:email => 'jarrodtaylor@city-slicking.com', :password => 'cityslicking', :admin => true)
johndickey   = User.create(:email => 'johndickey@city-slicking.com',   :password => 'cityslicking', :admin => true)
chriskimble  = User.create(:email => 'chriskimble@city-slicking.com',  :password => 'cityslicking', :admin => true)
doreenavila  = User.create(:email => 'doreenavila@city-slicking.com',  :password => 'cityslicking', :admin => true)
geraldavila  = User.create(:email => 'geraldavila@city-slicking.com',  :password => 'cityslicking', :admin => true)
jeremyavila  = User.create(:email => 'jeremyavila@city-slicking.com',  :password => 'cityslicking', :admin => true)
kylegoni     = User.create(:email => 'kylegoni@city-slicking.com',     :password => 'cityslicking', :admin => true)
larrykimble  = User.create(:email => 'larrykimble@city-slicking.com',  :password => 'cityslicking', :admin => true)
mattcross    = User.create(:email => 'mattcross@city-slicking.com',    :password => 'cityslicking', :admin => true)
nicoledickey = User.create(:email => 'nicoledickey@city-slicking.com', :password => 'cityslicking', :admin => true)
skiptaylor   = User.create(:email => 'skiptaylor@city-slicking.com',   :password => 'cityslicking', :admin => true)


tahoe_joe = Merchant.create(
  :name             => "Tahoe Joe's Famous Steakhouse",
  :owner            => 'Tahoe Joe',
  :manager          => 'Tahoe Tom',
  :email            => 'email@tahojoe.com',
  :site             => 'http://www.tahoejoe.com/',
  :type_of_business => 'Restaurant',
  :phone1           => '123-456-7890',
  :phone2           => '123-456-7890',
  :phone3           => '123-456-7890',
  :physical_street  => '123 Beach Blvd.',
  :physical_city    => 'Carmel',
  :physical_state   => 'CA',
  :physical_zip     => '93921',
  :mailing_street   => '123 Beach Blvd.',
  :mailing_city     => 'Carmel',
  :mailing_state    => 'CA',
  :mailing_zip      => '93921',
  :deals => [
    {
      :title => "50% Off Joe's-Style Roasted Chicken in Modesto",
      :active => true,
      :date_activated           => Chronic.parse('1 month ago'),
      :preview_authorized_by    => 'Gwen',
      :preview_authorized_date  => Chronic.parse('1 month ago'),
      :final_corrections_date   => Chronic.parse('10 days ago'),
      :publish_date             => Chronic.parse('today'),
      :expiration_date          => Chronic.parse('90 days from now'),
      :legalese                 => 'Limit 1 per customer.',
      :description              => Fixture.load('tahoe_joe'),
      :code                     => 'Seadog 1',
      :max_saves                => 1000,
      :first_percent            => 50,
      :return_percent           => 25,
      :max_returns              => 5,
      :city_deals => [{:city => san_jose}, {:city => modesto}, {:city => stockton}, {:city => sacramento}],
      :locations => [
        {:street => '3801 Pelandale Ave', :city => 'Modesto', :state => 'CA', :zip => '95356', :lat => '37.7022620', :long => '-121.0671580'}
      ]
    },
    {
      :title => 'Free Sashimi with Entree Purchase at Seadog Sushi Bar',
      :active => true,
      :date_activated           => Chronic.parse('1 month ago'),
      :preview_authorized_by    => 'Gwen',
      :preview_authorized_date  => Chronic.parse('1 month ago'),
      :final_corrections_date   => Chronic.parse('10 days ago'),
      :publish_date             => Chronic.parse('yesterday'),
      :expiration_date          => Chronic.parse('89 days from now'),
      :legalese                 => 'Limit 1 per customer.',
      :description              => Fixture.load('tahoe_joe'),
      :code                     => 'Seadog 2',
      :max_saves                => 1000,
      :first_percent            => 50,
      :return_percent           => 25,
      :max_returns              => 5,
      :city_deals => [{:city => lodi}, {:city => elk_grove}, {:city => turlock}],
      :locations => [
        {:street => '3801 Pelandale Ave', :city => 'Modesto', :state => 'CA', :zip => '95356', :lat => '37.7022620', :long => '-121.0671580'}
      ]
    }
  ]
)


trader_vic = Merchant.create(
  :name             => 'Trader Vic\'s',
  :owner            => 'Trader Vic',
  :manager          => 'Tahoe Jack',
  :email            => 'email@tradervics.com',
  :site             => 'http://www.tradervics.com/',
  :type_of_business => 'Tiki Bar',
  :phone1           => '123-456-7890',
  :phone2           => '123-456-7890',
  :phone3           => '123-456-7890',
  :physical_street  => '123 Beach Blvd.',
  :physical_city    => 'Carmel',
  :physical_state   => 'CA',
  :physical_zip     => '93921',
  :mailing_street   => '123 Beach Blvd.',
  :mailing_city     => 'Carmel',
  :mailing_state    => 'CA',
  :mailing_zip      => '93921',
  :deals => [
    {
      :title => 'Free Cannolis with Purchase of 2 Entrees at Salatino\'s',
      :active => true,
      :date_activated           => Chronic.parse('1 month ago'),
      :preview_authorized_by    => 'Gwen',
      :preview_authorized_date  => Chronic.parse('1 month ago'),
      :final_corrections_date   => Chronic.parse('10 days ago'),
      :publish_date             => Chronic.parse('2 days ago'),
      :expiration_date          => Chronic.parse('88 days from now'),
      :legalese                 => 'Exclusive to City Slicking users.',
      :description              => Fixture.load('salatinos_1'),
      :code                     => 'Salatinos 1',
      :max_saves                => 1000,
      :first_percent            => 50,
      :return_percent           => 25,
      :max_returns              => 5,
      :city_deals => [{:city => modesto}, {:city => stockton}, {:city => lodi}, {:city => sacramento}],
      :locations => [
        {:street => '626 S. Racine Ave.', :city => 'San Jose', :state => 'CA', :zip => '87654', :lat => '37.2923184', :long => '-121.8422625'}
      ]
    },
    {
      :title => '50% Off Drinks with Purchase of 2 Entrees at Salatino\'s',
      :active => true,
      :date_activated           => Chronic.parse('1 month ago'),
      :preview_authorized_by    => 'Gwen',
      :preview_authorized_date  => Chronic.parse('1 month ago'),
      :final_corrections_date   => Chronic.parse('10 days ago'),
      :publish_date             => Chronic.parse('3 days ago'),
      :expiration_date          => Chronic.parse('87 days from now'),
      :legalese                 => 'Exclusive to City Slicking users.',
      :description              => Fixture.load('salatinos_2'),
      :code                     => 'Salatinos 2',
      :max_saves                => 1000,
      :first_percent            => 50,
      :return_percent           => 25,
      :max_returns              => 5,
      :city_deals => [{:city => elk_grove}, {:city => turlock}, {:city => san_jose}],
      :locations => [
        {:street => '626 S. Racine Ave.', :city => 'San Jose', :state => 'CA', :zip => '87654', :lat => '37.2923184', :long => '-121.8422625'}
      ]
    }
  ]
)


starlight = Merchant.create(
  :name             => 'Starlight Six Drive-in',
  :owner            => 'Rose Tyler',
  :manager          => 'Mickey Smith',
  :email            => 'email@starlight.com',
  :site             => 'http://www.starlight.com/',
  :type_of_business => 'Theater',
  :phone1           => '123-456-7890',
  :phone2           => '123-456-7890',
  :phone3           => '123-456-7890',
  :physical_street  => '123 Beach Blvd.',
  :physical_city    => 'Carmel',
  :physical_state   => 'CA',
  :physical_zip     => '93921',
  :mailing_street   => '123 Beach Blvd.',
  :mailing_city     => 'Carmel',
  :mailing_state    => 'CA',
  :mailing_zip      => '93921',
  :deals => [
    {
      :title                    => '65% Off Lunch at Caminito Argentinian Grill',
      :active                   => true,
      :date_activated           => Chronic.parse('1 month ago'),
      :preview_authorized_by    => 'Gwen',
      :preview_authorized_date  => Chronic.parse('1 month ago'),
      :final_corrections_date   => Chronic.parse('10 days ago'),
      :publish_date             => Chronic.parse('4 days ago'),
      :expiration_date          => Chronic.parse('86 days from now'),
      :legalese                 => 'Lunch hours only.',
      :description              => Fixture.load('caminito_grill_1'),
      :code                     => 'Caminito 1',
      :max_saves                => 1000,
      :first_percent            => 50,
      :return_percent           => 25,
      :max_returns              => 5,
      :city_deals => [{:city => turlock}, {:city => san_jose}, {:city => modesto}],
      :locations => [
        {:street => '1629 N. Halsted', :city => 'Lodi', :state => 'CA', :zip => '76543', :lat => '38.1301968', :long => '-121.2724473'}
      ]
    },
    {
      :title                    => 'Free Hot Drinks with Desert Purchase at Caminito Argentinian Grill',
      :active                   => true,
      :date_activated           => Chronic.parse('1 month ago'),
      :preview_authorized_by    => 'Rose',
      :preview_authorized_date  => Chronic.parse('1 month ago'),
      :final_corrections_date   => Chronic.parse('10 days ago'),
      :publish_date             => Chronic.parse('5 days ago'),
      :expiration_date          => Chronic.parse('85 days from now'),
      :legalese                 => 'Limit 3 per customer.',
      :description              => Fixture.load('caminito_grill_2'),
      :code                     => 'Caminito 2',
      :max_saves                => 1000,
      :first_percent            => 50,
      :return_percent           => 25,
      :max_returns              => 5,
      :city_deals => [{:city => stockton}, {:city => lodi}, {:city => elk_grove}, {:city => sacramento}],
      :locations => [
        {:street => '1629 N. Halsted', :city => 'Lodi', :state => 'CA', :zip => '76543', :lat => '38.1301968', :long => '-121.2724473'}
      ]
    }
  ]
)


threadless = Merchant.create(
  :name             => 'Threadless',
  :owner            => 'Gwen Cooper',
  :manager          => 'Owen Harper',
  :email            => 'email@threadless.com',
  :site             => 'http://www.threadless.com/',
  :type_of_business => 'Online Retailer',
  :phone1           => '123-456-7890',
  :phone2           => '123-456-7890',
  :phone3           => '123-456-7890',
  :physical_street  => '123 Beach Blvd.',
  :physical_city    => 'Carmel',
  :physical_state   => 'CA',
  :physical_zip     => '93921',
  :mailing_street   => '123 Beach Blvd.',
  :mailing_city     => 'Carmel',
  :mailing_state    => 'CA',
  :mailing_zip      => '93921',
  :deals => [
    {      
      :title                    => 'Buy 1 Get 1 Half Off at Threadless Retail Stores',
      :active                   => true,
      :date_activated           => Chronic.parse('1 month ago'),
      :preview_authorized_by    => 'Gwen',
      :preview_authorized_date  => Chronic.parse('1 month ago'),
      :final_corrections_date   => Chronic.parse('10 days ago'),
      :publish_date             => Chronic.parse('6 days ago'),
      :expiration_date          => Chronic.parse('84 days from now'),
      :legalese                 => 'Only valid at our retail store locations.',
      :description              => Fixture.load('threadless_1'),
      :code                     => 'Threadless',
      :max_saves                => 1000,
      :first_percent            => 50,
      :return_percent           => 25,
      :max_returns              => 5,
      :city_deals => [{:city => san_jose}, {:city => stockton}, {:city => modesto}, {:city => lodi}, {:city => elk_grove}, {:city => turlock}, {:city => sacramento}],
      :locations => [
        {:street => '3011 N. Broadway St.', :city => 'San Francisco', :state => 'CA', :zip => '54321', :lat => '37.7928060', :long => '-122.4463628'},
        {:street => '1905 W. Division St.', :city => 'San Francisco', :state => 'CA', :zip => '54321', :lat => '37.7692101', :long => '-122.4077936'}
      ]
    }
  ]
)
