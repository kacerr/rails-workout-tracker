class AddUserIdColumnToExcercises < ActiveRecord::Migration
  def change
    add_column :excercises, :user_id, :integer
  end
end
