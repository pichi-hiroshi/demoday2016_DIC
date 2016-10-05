class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :message
      t.text :datasource
      t.text :datasource_url
      t.integer :user_id
      t.string :user_name
      t.string :provider
      t.string :image_url
      t.string :avatar
      t.string :name
      t.belongs_to :user
      t.belongs_to :board

      t.timestamps null: false
    end
  end
end
