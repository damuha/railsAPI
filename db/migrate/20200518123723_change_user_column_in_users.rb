class ChangeUserColumnInUsers < ActiveRecord::Migration[6.0]
  def change
    create_table "users", force: :cascade do |t|
      t.integer :user_id
      t.string :user_name
      t.timestamps 
    end
  end
end
