class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string  :parent_type, :null => false
      t.integer :parent_id,   :null => false
      t.string  :content
      t.timestamps
    end

    add_column :functions, :comments_count, :integer, :default => 0
    add_column :implementations, :comments_count, :integer, :default => 0

    add_index :comments, :user_id
    add_index :comments, [:parent_type, :parent_id]
  end
end
