class AddColumnShowInGroupsStreamToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :show_in_groups_stream, :integer
  end
end
