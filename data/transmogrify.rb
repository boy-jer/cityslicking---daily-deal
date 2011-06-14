#City.create(:name => 'San Francisco/Bay Area, CA',   :short_name => 'sanfrancisco')
#City.create(:name => 'L.A Area, CA',   :short_name => 'losangeles')

elk_grove = City.first(:short_name => 'elkgrove')
elk_grove.destroy if elk_grove

sac = City.first(:short_name => 'sacramento')
sac.update(:name => 'Sacramento Area, CA') if sac

lodi = City.first(:short_name => 'lodi')
lodi.destroy if lodi

stockton = City.first(:short_name => 'stockton')
stockton.update(:name => 'Stockton/Lodi, CA', :short_name => 'stockton-lodi') if stockton

sf = City.first(:short_name => 'sanfrancisco')
sf.update(:name => 'S.F./Bay Area, CA') if sf

la = City.first(:short_name => 'losangeles')
la.update(:name => 'L.A. Area, CA') if la

turlock = City.first(:short_name => 'turlock')
turlock.destroy if turlock
