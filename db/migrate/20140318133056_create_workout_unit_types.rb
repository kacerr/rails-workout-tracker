class CreateWorkoutUnitTypes < ActiveRecord::Migration
  def change
    create_table :workout_unit_types do |t|
      t.string :name
      t.integer :category
      t.integer :difficulty
      t.string :description
      t.string :icon

      t.timestamps
    end
  end
end
