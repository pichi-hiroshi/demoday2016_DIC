class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post_title
      t.text :post_message
      t.text :datasource
      t.text :datasource_url
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
