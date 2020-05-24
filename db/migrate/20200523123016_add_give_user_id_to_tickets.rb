class AddGiveUserIdToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :give_user_id, :integer, :after => :give_flg
    add_column :tickets, :user_id, :integer, :after => :ticket_name
  end
end