class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.datetime :info_date
      t.string :info_title
      t.text :info_content

      t.timestamps null: false
    end
  end
end
