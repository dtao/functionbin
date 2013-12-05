class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.integer :user_id,    :null => false
      t.string  :name,       :null => false
      t.string  :description
      t.text    :example,    :null => false

      # Cached calculations
      t.integer :implementations_count, :default => 0

      t.timestamps
    end

    add_index :functions, :user_id
    add_index :functions, :name, :unique => true
  end
end
