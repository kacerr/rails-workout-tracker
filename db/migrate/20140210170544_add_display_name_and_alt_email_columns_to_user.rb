class AddDisplayNameAndAltEmailColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string
    add_column :users, :alternative_email, :string
  end
end
