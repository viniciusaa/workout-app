class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.integer :duration_in_min
      t.text :workout
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
