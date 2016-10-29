class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.text :contents
      t.string :mail
      t.boolean :reply, default: true
      t.boolean :privacy, default: false

      t.timestamps null: false
    end
  end
end
