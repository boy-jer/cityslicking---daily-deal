san_jose  = City.create(:name => 'San Jose, CA',  :short_name => 'sanjose' )
modesto   = City.create(:name => 'Modesto, CA',   :short_name => 'modesto' )
stockton  = City.create(:name => 'Stockton, CA',  :short_name => 'stockton')
lodi      = City.create(:name => 'Lodi, CA',      :short_name => 'lodi'    )
elk_grove = City.create(:name => 'Elk Grove, CA', :short_name => 'elkgrove')
turlock   = City.create(:name => 'Turlock, CA',   :short_name => 'turlock' )

jarrod = User.create(:email => 'jarrodtaylor@cityslicking.com', :password => 'demo')
john   = User.create(:email => 'john@cityslicking.com',         :password => 'demo')
