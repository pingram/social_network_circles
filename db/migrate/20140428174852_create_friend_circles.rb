class CreateFriendCircles < ActiveRecord::Migration
  def change
    create_table :friend_circles do |t|
      t.string  :name
      t.integer :owner_id
      t.timestamps
    end
    add_index :friend_circles, :owner_id
  end
end
