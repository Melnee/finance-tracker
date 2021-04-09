class FriendshipsController < ApplicationController
    def add_friend
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
