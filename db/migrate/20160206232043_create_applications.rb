class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :username
      t.string :email
      t.integer :level
      t.text :about
      t.integer :thlevel
      t.string :status

      t.timestamps null: false
    end
    add_index :applications, :email, unique: true
  end
end
