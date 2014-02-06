class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :message_type
      t.string :status

      t.timestamps
    end
  end
end
