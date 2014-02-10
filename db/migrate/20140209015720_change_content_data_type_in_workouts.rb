class ChangeContentDataTypeInWorkouts < ActiveRecord::Migration
  def change
  	change_column :workouts, :content, :text
  end
end
