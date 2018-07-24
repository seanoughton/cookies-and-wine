class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
        t.integer :rating_value
        t.integer :pairing_id
        t.integer :user_id
      t.timestamps
    end
  end
end
