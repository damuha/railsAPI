class ChangeTichetNameToTicketName < ActiveRecord::Migration[6.0]
  def change
    rename_column :tickets, :tichet_name, :ticket_name
  end
end
