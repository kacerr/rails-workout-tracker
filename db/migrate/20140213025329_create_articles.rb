class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.string :content
      t.string :article_type

      t.timestamps
    end
  end
end
