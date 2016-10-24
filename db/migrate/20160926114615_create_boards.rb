class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :board_url
      t.string :board_title
      t.string :board_discription
      t.string :board_image
      t.string :board_posttext
      t.string :category
      t.belongs_to :user
      t.belongs_to :dashboard

      t.timestamps null: false
    end
  end
end
