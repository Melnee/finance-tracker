class FriendshipsController < ApplicationController
    def add_friend
        friend = User.find(params[:id])
        #then create a friendship relationship with the friend you found
        current_user.friendships.build(friend_id: friend.id)
        if current_user.save
            flash[:notice] = "You are now following #{friend.full_name}"
        else
            flash[:alert] = "There was something wrong with the tracking request"
        end
        redirect_to my_friends_path
    end

    def unfriend
        #find and destroy the relationship
        #where returns an array, so make sure that you select the first (and only relationship) returned in that array
        friendship = current_user.friendships.where(friend_id: params[:id]).first
        friendship.destroy
        flash[:notice] = "Stopped Following"
        redirect_to my_friends_path
    end

end
