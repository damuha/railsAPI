class AddGiveflgToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :give_flg, :integer
  end
end
