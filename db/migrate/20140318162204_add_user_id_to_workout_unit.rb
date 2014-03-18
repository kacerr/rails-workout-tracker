class AddUserIdToWorkoutUnit < ActiveRecord::Migration
  def change
    add_column :workout_units, :user_id, :integer
  end
end
