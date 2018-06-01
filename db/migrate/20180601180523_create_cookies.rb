class CreateCookies < ActiveRecord::Migration[5.2]
  def change
    create_table :cookies do |t|
    	t.string :cookie_name
    	t.string :description
    	t.string :link
      t.timestamps
    end
  end
end
