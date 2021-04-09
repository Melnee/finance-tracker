class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def stock_already_tracked?(ticker_symbol)
    #first check if the stock is already in the database even 
    stock = Stock.check_db(ticker_symbol)
    #if it's not in the database it's for sure not tracked by the user, so return false if stock is nil
    return false unless stock
    #then check if the stock is in the user's stocks, aka implied as self.stocks but shorthand written as stocks.where etc
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    #the self. is already implied in front of "stocks"
    #returns true if the self.stocks count is under the limit of 10
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    #check under the limit, and check if the stock is NOT already tracked
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    #return the first name and last name in a string if self has first_name or last_name
    return "#{first_name} #{last_name}" if first_name || last_name
    #else, just return this string that says anonymous
    "Anonymous" 
  end

  #class level method requires self
  def self.matches(field_name, param)
    #Active record query that returns array of users who's field name contains wildcarded param
    where("#{field_name} like ?", "%#{param}%")
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  #search method to prepare the param for query
  def self.search(param)
    #remove spaces before and after
    param.strip!
    #by concatenating the returns here you ensure you check if the search params match  any of the three fields
    #even if that means 2/3 fields will return blanks, one of the concatenated returns will contain something
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq   #uniq method ensures you won't return the same user twice
    #if there are no matches at all, return nil
    return nil unless to_send_back
    to_send_back
  end
  
  def except_current_user(users)
    #use the reject method to loop through the users array, and and if any of their ids match the current user, then take them out 
    users.reject! { |user| user.id == self.id }
    
  end

end
