class AddColumnPublicToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :public, :integer
  end
end
