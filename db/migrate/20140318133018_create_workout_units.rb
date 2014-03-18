class CreateWorkoutUnits < ActiveRecord::Migration
  def change
    create_table :workout_units do |t|
      t.datetime :date
      t.integer :workout_unit_type_id

      t.timestamps
    end
  end
end
