class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
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

end
