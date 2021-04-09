class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friend = User.where("first_name like?", params[:friend]).first
      if @friend
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
