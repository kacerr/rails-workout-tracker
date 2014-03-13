class AddEmailToUsersOauth < ActiveRecord::Migration
  def change
    add_column :users_oauths, :email, :string
  end
end
