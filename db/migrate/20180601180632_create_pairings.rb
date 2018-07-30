class CreatePairings < ActiveRecord::Migration[5.2]
  def change
    create_table :pairings do |t|
      t.float :user_rating
    	t.integer :wine_id
    	t.integer :cookie_id
    	t.integer :user_id
      t.integer :comments_count, default: 0
      t.timestamps
    end
  end
end
