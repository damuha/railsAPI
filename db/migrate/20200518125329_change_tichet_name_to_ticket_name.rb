class ChangeTichetNameToTicketName < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :ticket_name
      t.timestamps
    end
  end
end
