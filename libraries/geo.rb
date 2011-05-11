class Geocode
  
  def self.get_coords_from_addr(street, city, state)
    addr = CGI.escape(street + ',' + city + ',' + state)
    maps_api_response = JSON.parse(Net::HTTP.get_response(URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{addr}&sensor=false")).body)['results'].first['geometry']['location']
    coords = {:lat => maps_api_response['lat'], :long => maps_api_response['lng']}
    return coords
  end
  
end
