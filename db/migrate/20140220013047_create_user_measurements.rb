class CreateUserMeasurements < ActiveRecord::Migration
  def change
    create_table :user_measurements do |t|
      t.integer :user_id
      t.integer :measurement_id
      t.integer :value
      t.string :value_string
      t.text :note

      t.timestamps
    end
  end
end
