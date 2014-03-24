class AddColumnDefaultGroupIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_group_id, :integer
  end
end
