class CreateValueLists < ActiveRecord::Migration
  def change
    create_table :value_lists do |t|
      t.string :name
      t.string :value
      t.string :description
      t.integer :order
      t.boolean :visible

      t.timestamps
    end
  end
end
