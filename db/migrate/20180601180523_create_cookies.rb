class CreateCookies < ActiveRecord::Migration[5.2]
  def change
    create_table :cookies do |t|

      t.timestamps
    end
  end
end
