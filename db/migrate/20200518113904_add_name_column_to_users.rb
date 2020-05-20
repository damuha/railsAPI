class AddNameColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    create_table "users", force: :cascade do |t|
      t.string :name
      t.timestamps 
    end
  end
endclear
