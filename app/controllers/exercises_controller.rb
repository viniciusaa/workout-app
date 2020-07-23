class ExercisesController < ApplicationController
  before_action :select_exercise, except: [:index, :new, :create]

  def index
    @exercises = current_user.exercises.paginate(page: params[:page], per_page: 3)
    @search = current_user.exercises.search(params[:search])
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
end
