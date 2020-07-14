class ExercisesController < ApplicationController
  before_action :select_exercise, only: [:edit, :update, :show]


  def index
    @exercises = current_user.exercises
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

  private

  def select_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:duration_in_min, :workout, :workout_date, :user_id)
  end
end
