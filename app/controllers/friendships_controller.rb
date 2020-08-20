class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    params[:user_id] = current_user.id

    Friendship.create(friendship_params) unless current_user.follows?(friend) || current_user == friend
    redirect_to root_path
  end

  def show
  end

  def destroy
  end

  private

  def friendship_params
    params.permit(:friend_id, :user_id)
  end
end
