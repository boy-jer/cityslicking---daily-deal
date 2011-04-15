module Fixture
  def self.load(file)
    contents = ''
    File.open("./data/fixtures/#{file}").each_line { |line| contents << line }
    contents
  end
end


san_jose  = City.create(:name => 'San Jose, CA',  :short_name => 'sanjose' )
modesto   = City.create(:name => 'Modesto, CA',   :short_name => 'modesto' )
stockton  = City.create(:name => 'Stockton, CA',  :short_name => 'stockton')
lodi      = City.create(:name => 'Lodi, CA',      :short_name => 'lodi'    )
elk_grove = City.create(:name => 'Elk Grove, CA', :short_name => 'elkgrove')
turlock   = City.create(:name => 'Turlock, CA',   :short_name => 'turlock' )


jarrod = User.create(:email => 'jarrodtaylor@cityslicking.com', :password => 'demo')
john   = User.create(:email => 'john@cityslicking.com',         :password => 'demo')


seadog_sushi_bar = Dealer.create(:name => 'Seadog Sushi Bar',
  :deals => [
    {
      :title => '50% Off Entrees at Seadog Sushi Bar',
      :active => true,
      :publish_date => Chronic.parse('today'),
      :expiration_date => Chronic.parse('90 days from now'),
      :legalese => 'Limit 1 per customer.',
      :description => Fixture.load('seadog_sushi_bar_1'),
      :code => 'Seadog 1',
      :max_saves => 1000,
      :first_percent => 50,
      :return_percent => 25,
      :max_returns => 5,
      :city_deals => [{:city => san_jose}, {:city => modesto}, {:city => stockton}],
      :locations => [
        {:street => '123 Fake Street', :city => 'Elk Grove', :state => 'CA', :zip => '98765'}
      ]
    },
    {
      :title => 'Free Sashimi with Entree Purchase at Seadog Sushi Bar',
      :active => true,
      :publish_date => Chronic.parse('yesterday'),
      :expiration_date => Chronic.parse('89 days from now'),
      :legalese => 'Limit 1 per customer.',
      :description => Fixture.load('seadog_sushi_bar_2'),
      :code => 'Seadog 2',
      :max_saves => 1000,
      :first_percent => 50,
      :return_percent => 25,
      :max_returns => 5,
      :city_deals => [{:city => lodi}, {:city => elk_grove}, {:city => turlock}],
      :locations => [
        {:street => '123 Fake Street', :city => 'Elk Grove', :state => 'CA', :zip => '98765'}
      ]
    }
  ]
)


salatinos = Dealer.create(:name => 'Salatino\'s',
  :deals => [
    {
      :title => 'Free Cannolis with Purchase of 2 Entrees at Salatino\'s',
      :active => true,
      :publish_date => Chronic.parse('2 days ago'),
      :expiration_date => Chronic.parse('88 days from now'),
      :legalese => 'Exclusive to City Slicking users.',
      :description => Fixture.load('salatinos_1'),
      :code => 'Salatinos 1',
      :max_saves => 1000,
      :first_percent => 50,
      :return_percent => 25,
      :max_returns => 5,
      :city_deals => [{:city => modesto}, {:city => stockton}, {:city => lodi}],
      :locations => [
        {:street => '626 S. Racine Ave.', :city => 'San Jose', :state => 'CA', :zip => '87654'}
      ]
    },
    {
      :title => '50% Off Drinks with Purchase of 2 Entrees at Salatino\'s',
      :active => true,
      :publish_date => Chronic.parse('3 days ago'),
      :expiration_date => Chronic.parse('87 days from now'),
      :legalese => 'Exclusive to City Slicking users.',
      :description => Fixture.load('seadog_sushi_bar_2'),
      :code => 'Salatinos 2',
      :max_saves => 1000,
      :first_percent => 50,
      :return_percent => 25,
      :max_returns => 5,
      :city_deals => [{:city => elk_grove}, {:city => turlock}, {:city => san_jose}],
      :locations => [
        {:street => '626 S. Racine Ave.', :city => 'San Jose', :state => 'CA', :zip => '87654'}
      ]
    }
  ]
)


caminito_grill = Dealer.create(:name => 'Caminito Argentinian Grill',
  :deals => [
    {
      :title => '65% Off Lunch at Caminito Argentinian Grill',
      :active => true,
      :publish_date => Chronic.parse('4 days ago'),
      :expiration_date => Chronic.parse('86 days from now'),
      :legalese => 'Lunch hours only.',
      :description => Fixture.load('caminito_grill_1'),
      :code => 'Caminito 1',
      :max_saves => 1000,
      :first_percent => 50,
      :return_percent => 25,
      :max_returns => 5,
      :city_deals => [{:city => turlock}, {:city => san_jose}, {:city => modesto}],
      :locations => [
        {:street => '1629 N. Halsted', :city => 'Lodi', :state => 'CA', :zip => '76543'}
      ]
    },
    {
      :title => 'Free Hot Drinks with Desert Purchase at Caminito Argentinian Grill',
      :active => true,
      :publish_date => Chronic.parse('5 days ago'),
      :expiration_date => Chronic.parse('85 days from now'),
      :legalese => 'Limit 3 per customer.',
      :description => Fixture.load('caminito_grill_2'),
      :code => 'Caminito 2',
      :max_saves => 1000,
      :first_percent => 50,
      :return_percent => 25,
      :max_returns => 5,
      :city_deals => [{:city => stockton}, {:city => lodi}, {:city => elk_grove}],
      :locations => [
        {:street => '1629 N. Halsted', :city => 'Lodi', :state => 'CA', :zip => '76543'}
      ]
    }
  ]
)


threadless = Dealer.create(:name => 'Threadless',
  :deals => [
    {
      :title => 'Buy 1 Get 1 Half Off at Threadless Retail Stores',
      :active => true,
      :publish_date => Chronic.parse('6 days ago'),
      :expiration_date => Chronic.parse('84 days from now'),
      :legalese => 'Only valid at our retail store locations.',
      :description => Fixture.load('threadless_1'),
      :code => 'Threadless 1',
      :max_saves => 1000,
      :first_percent => 50,
      :return_percent => 25,
      :max_returns => 5,
      :city_deals => [{:city => san_jose}, {:city => stockton}, {:city => modesto}, {:city => lodi}, {:city => elk_grove}, {:city => turlock}],
      :locations => [
        {:street => '3011 N. Broadway St.', :city => 'San Francisco', :state => 'CA', :zip => '54321'},
        {:street => '1905 W. Division St.', :city => 'San Francisco', :state => 'CA', :zip => '54321'}
      ]
    }
  ]
)
