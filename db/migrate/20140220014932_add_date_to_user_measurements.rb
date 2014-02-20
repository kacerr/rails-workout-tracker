class AddDateToUserMeasurements < ActiveRecord::Migration
  def change
    add_column :user_measurements, :date, :datetime
  end
end
