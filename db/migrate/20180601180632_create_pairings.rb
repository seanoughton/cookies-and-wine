class CreatePairings < ActiveRecord::Migration[5.2]
  def change
    create_table :pairings do |t|

      t.timestamps
    end
  end
end
