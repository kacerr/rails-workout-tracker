class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.datetime :birth_date
      t.string :country
      t.string :city
      t.text :bio
      t.float :height
      t.float :weight

      t.timestamps
    end
  end
end
