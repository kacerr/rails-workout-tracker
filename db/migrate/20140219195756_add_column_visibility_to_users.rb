class AddColumnVisibilityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visibility, :integer
  end
end
