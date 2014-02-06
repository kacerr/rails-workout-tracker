class AddDateToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :date, :datetime
  end
end
