class AddSummaryFromToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :summary_from, :datetime
  end
end
