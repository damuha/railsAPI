class ChangeMUsersToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_table :m_users, :users
  end
end
