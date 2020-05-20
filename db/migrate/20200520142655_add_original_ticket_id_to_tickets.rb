class AddOriginalTicketIdToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :original_ticket_id, :integer
  end
end
