class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.integer :user_id,           :null => false
      t.integer :implementation_id, :null => false
      t.timestamps
    end

    add_index :upvotes, [:user_id, :implementation_id]
    add_index :upvotes, :implementation_id
  end
end
