class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends_result = User.search(params[:friend])
      #call the except_current_user method you made in the User.rb class to take out the current user from that array
      @friends = current_user.except_current_user(@friends_result)
      if @friends_result
          @friends = current_user.friends
          render 'users/my_friends'
      else 
          flash[:alert] = "We couldn't find that friend! Please try again"
          redirect_to my_friends_path
      end
    else
      flash[:notice] = "Please enter a friend's name"
      redirect_to my_friends_path
    end
  end

end
