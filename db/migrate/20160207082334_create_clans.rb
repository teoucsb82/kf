class CreateClans < ActiveRecord::Migration
  def change
    create_table :clans do |t|
      t.string :tag
      t.text :data
      t.timestamps null: false
    end
    add_index :clans, :tag, unique: true
  end
end
