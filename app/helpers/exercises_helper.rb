module ExercisesHelper
  def time_to_expire(exercise)
    time = ((exercise.created_at.to_date + 7) - Time.current.to_date).to_i
    pluralize(time, "day")
  end
end
