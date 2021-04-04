class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #registerable means User can be created
  #recoverable means the password can be reset
  #rememberable means the user can be remembered in the website and session stored longtime
  #confirmable means you can confirm password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
