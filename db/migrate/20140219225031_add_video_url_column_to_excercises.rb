class AddVideoUrlColumnToExcercises < ActiveRecord::Migration
  def change
    add_column :excercises, :video_url, :string
  end
end
