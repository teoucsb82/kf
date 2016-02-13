class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.integer :forum_id

      t.timestamps null: false
    end
    add_index :topics, :forum_id
  end
end
