class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,  :null => false
      t.string :email, :null => false

      # Cached calculations
      t.integer :score, :default => 0
      t.integer :functions_count, :default => 0
      t.integer :implementations_count, :default => 0

      t.timestamps
    end

    add_index :users, :name,  :unique => true
    add_index :users, :email, :unique => true
  end
end
