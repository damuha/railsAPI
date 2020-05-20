class ChangeUsersIdToNotNull < ActiveRecord::Migration[6.0]
  def change
    create_table "users", force: :cascade do |t|
      t.integer :user_id,null: false
      t.string :user_name
      t.timestamps 
    end
  end
end
