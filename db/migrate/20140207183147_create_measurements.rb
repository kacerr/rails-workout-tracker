class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.string :name
      t.string :description
      t.string :datatype

      t.timestamps
    end
  end
end
