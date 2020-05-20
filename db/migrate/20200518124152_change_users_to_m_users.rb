class ChangeUsersToMUsers < ActiveRecord::Migration[6.0]
  def change
    rename_table :users, :m_users
  end
end
