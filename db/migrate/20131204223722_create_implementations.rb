class CreateImplementations < ActiveRecord::Migration
  def change
    create_table :implementations do |t|
      t.integer :user_id,     :null => false
      t.integer :function_id, :null => false
      t.text    :source,      :null => false

      # Cached calculations
      t.integer :score, :default => 0

      t.timestamps
    end

    add_index :implementations, :user_id
    add_index :implementations, :function_id
  end
end
