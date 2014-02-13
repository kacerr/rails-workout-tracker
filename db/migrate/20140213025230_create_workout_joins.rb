class CreateWorkoutJoins < ActiveRecord::Migration
  def change
    create_table :workout_joins do |t|
      t.integer :workout_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end
end
