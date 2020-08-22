class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    params[:user_id] = current_user.id

    Friendship.create(friendship_params) unless current_user.follows?(friend) || current_user == friend
    redirect_to root_path
  end

  def show
    @friend = Friendship.find(params[:id]).friend
    @exercises = @friend.exercises.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    friend = @friendship.friend.full_name
    if @friendship.destroy
      flash[:notice] = "#{friend} unfollowed"
    else
      flash.now[:alert] = "#{friend} could not be unfollowed"
    end
    redirect_to user_exercises_path(current_user)
  end

  private

  def friendship_params
    params.permit(:friend_id, :user_id)
  end
end
