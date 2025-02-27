class ExercisesController < ApplicationController
  before_action :select_exercise, except: [:index, :new, :create]

  def index
    @exercises = current_user.exercises.paginate(page: params[:exercises_page], per_page: 5)
    @friends = current_user.friends.paginate(page: params[:friends_page], per_page: 10)
    @search = current_user.exercises.search_exercise(params[:search_exercise])
    set_current_room
    @message = Message.new
    @messages = current_room.messages if current_room
    @followers = Friendship.where(friend_id: current_user.id)
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)
    if @exercise.save
      flash[:notice] = "Exercise has been created"
      redirect_to user_exercise_path(current_user, @exercise)
    else
      flash[:alert] = "Failed to created exercise"
      render "new"
    end
  end

  def edit; end

  def update
    if @exercise.update(exercise_params)
      flash[:notice] = "Exercise has been updated"
      redirect_to user_exercise_path(current_user, @exercise)
    else
      flash[:alert] = "Failed to update exercise"
      render "new"
    end
  end

  def show; end

  def destroy
    @exercise.destroy
    flash[:notice] = "Exercise was successfully deleted"
    redirect_to user_exercises_path(current_user)
  end

  private

  def select_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:duration_in_min, :workout, :user_id)
  end

  def set_current_room
    if params[:roomId]
      @room = Room.find_by(id: params[:roomId])
    else
      @room = current_user.room
    end
    session[:current_room] = @room.id if @room
  end
end
