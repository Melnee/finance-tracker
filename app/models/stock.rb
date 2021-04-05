class Stock < ApplicationRecord
    def self.new_lookup(ticker_symbol)
        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
            secret_token: Rails.application.credentials.iex_client[:sandbox_secret_key],
            endpoint: 'https://sandbox.iexapis.com/v1'
        )
        #now return the price
        #inside the class, the Stock.new is implied, here you only have to write new
        #in the name param, you're finding the company by the ticker symbol
        #and then chaining that found company to get it's full name
        new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name,  last_price: client.price(ticker_symbol))
    end

end
