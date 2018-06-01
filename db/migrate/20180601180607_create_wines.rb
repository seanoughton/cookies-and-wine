class CreateWines < ActiveRecord::Migration[5.2]
  def change
    create_table :wines do |t|
    	t.string :wine_name
    	t.string :grape_varietal
    	t.string :origin
    	t.string :description
      t.timestamps
    end
  end
end
