class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.text :board_url
      t.string :board_title
      t.text :board_content

      t.timestamps null: false
    end
  end
end