class AddSlugToExcercise < ActiveRecord::Migration
  def change
		add_column :excercises, :slug, :string, :unique => true
  end
end
