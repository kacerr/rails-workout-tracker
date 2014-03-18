class ChangeWorkoutUnitTypes < ActiveRecord::Migration
  def change
  	change_column :workout_unit_types, :category, :string
  	change_column :workout_unit_types, :description, :text
  	add_column :workout_unit_types, :color, :string
  end
end
