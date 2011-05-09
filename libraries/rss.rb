get '/deals/rss/:city' do
  deals = City.get(params[:city]).deals(:order => :expiration_date.asc, :active => true, :publish_date.lt => Chronic.parse('now'), :expiration_date.gt => Chronic.parse('now'))
  
  builder do |xml|
    xml.instruct! :xml, :version => '1.0'
    xml.rss :version => "2.0" do
      xml.channel do
        xml.title "City Slicking"
        xml.description "Free the coupons."
        xml.link "http://city-slicking.com/"

        deals.each do |deal|
          xml.item do
            xml.title deal.title
            xml.link "http://city-slicking.com/deals/#{deal.id}"
            xml.description markdown deal.description
            xml.pubDate Time.parse(deal.publish_date.to_s).rfc822()
          end
        end
      end
    end
  end
  
end
