class RenameIdColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :id, :user_id
  end
end
