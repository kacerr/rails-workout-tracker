class ChangeDescriptionDataTypeInExcercise < ActiveRecord::Migration
  def change
  	change_column :excercises, :description, :text
  end
end
