class CreatePairings < ActiveRecord::Migration[5.2]
  def change
    create_table :pairings do |t|
    	t.string :name
    	t.integer :rating
    	t.integer :wine_id
    	t.integer :cookie_id
    	t.integer :user_id
      t.timestamps
    end
  end
end
