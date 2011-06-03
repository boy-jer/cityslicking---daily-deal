get '/home/?' do
  redirect '/'
end

get '/?' do
  @deals = Deal.featured(session[:city_id])
  deliver 'featured'
end

get '/deals/?' do
  if params[:find] && params[:find].length > 0
    session[:user] ? @deals = Deal.search(session[:city_id], params[:find], session[:user]) : @deals = Deal.search(session[:city_id], params[:find])
  else
    session[:user] ? @deals = Deal.unsaved(session[:city_id], session[:user]) : @deals = Deal.live(session[:city_id])
  end
  deliver 'deals'
end

get '/deals/return/?' do
  @deals = Deal.return(session[:city_id], session[:user])
  deliver 'deals'
end

get '/deals/reserved/?' do
  @deals = Deal.reserved(session[:city_id], session[:user])
  deliver 'deals'
end

get '/deals/:id/?' do
  @deal = Deal.get(params[:id])
  deliver 'deal'
end



class Deal
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at
  
  property  :title,                   Text
  property  :created_by,              Integer
  property  :active,                  Boolean,  :default => false
  property  :date_activated,          Date
  property  :preview_authorized_by,   String
  property  :preview_authorized_date, Date
  property  :final_corrections_date,  Date,     :default => Chronic.parse('1 month from now')
  property  :publish_date,            Date,     :default => Chronic.parse('now')
  property  :expiration_date,         Date,     :default => Chronic.parse('3 months from now')
  property  :legalese,                Text
  property  :description,             Text
  property  :code,                    String
  property  :max_saves,               Integer,  :default => 10000
  property  :first_percent,           Integer,  :default => 50
  property  :return_percent,          Integer,  :default => 25
  property  :max_returns,             Integer,  :default => 5
  property  :neighborhood,            String
  
  property  :date_sent_1,       Date,  :default => Chronic.parse('now')
  property  :amount_sent_1,     Float, :default => 0
  property  :date_received_1,   Date,  :default => Chronic.parse('now')
  property  :amount_received_1, Float, :default => 0
  property  :salesman_1,        Integer

  property  :date_sent_2,       Date,  :default => Chronic.parse('now')
  property  :amount_sent_2,     Float, :default => 0
  property  :date_received_2,   Date,  :default => Chronic.parse('now')
  property  :amount_received_2, Float, :default => 0
  property  :salesman_2,        Integer

  property  :date_sent_3,       Date,  :default => Chronic.parse('now')
  property  :amount_sent_3,     Float, :default => 0
  property  :date_received_3,   Date,  :default => Chronic.parse('now')
  property  :amount_received_3, Float, :default => 0
  property  :salesman_3,        Integer

  property  :date_sent_4,       Date,  :default => Chronic.parse('now')
  property  :amount_sent_4,     Float, :default => 0
  property  :date_received_4,   Date,  :default => Chronic.parse('now')
  property  :amount_received_4, Float, :default => 0
  property  :salesman_4,        Integer  
  
  belongs_to :merchant
  has n,     :locations
  has n,     :cities, :through => Resource
  
  has n, :confirmations
  has n, :users, :through => :confirmations
  
  def self.live(city)
    City.get(city).deals(:order => :expiration_date.asc, :active => true, :publish_date.lt => Chronic.parse('now'), :expiration_date.gt => Chronic.parse('now'))
  end
  
  def self.savable(live, user)
    confirmations = Confirmation.all(:user_id => user)
    deals = []
    live.each do |d|
      deals << d if confirmations.count(:deal_id => d.id) < d.max_returns
    end
    deals
  end
  
  def self.search(city, query, user = nil)
    unless user.nil?
      self.savable(self.live(city).all(:title.like => "%#{query}%"), user)
    else
      self.live(city).all(:title.like => "%#{query}%")
    end
  end
    
  def self.featured(city)
    City.get(city).deals(:order => :publish_date.desc, :limit => 3, :active => true, :publish_date.lt => Chronic.parse('now'), :expiration_date.gt => Chronic.parse('now'))
  end
  
  def self.unsaved(city, user)
    confirmations = []
    Confirmation.all(:user_id => user).each {|c| confirmations << c.deal_id}
    self.savable(Deal.live(city).all(:id.not => confirmations), user)
  end
  
  def self.return(city, user)
    confirmations = []
    Confirmation.all(:user_id => user).each {|c| confirmations << c.deal_id}
    self.savable(Deal.live(city).all(:id => confirmations), user)
  end
  
  def self.reserved(city, user)    
    reservations = []
    Reservation.all(:user_id => user).each {|r| reservations << r.deal_id}
    self.savable(Deal.live(city).all(:id => reservations), user)
  end
  
end


class Location
  include DataMapper::Resource
  
  property    :id,          Serial
  property    :deleted_at,  ParanoidDateTime
  timestamps  :at
  
  property :street, String
  property :city,   String
  property :state,  String
  property :zip,    String
  
  property :lat,    String
  property :long,   String
  
  belongs_to :deal
    
end
