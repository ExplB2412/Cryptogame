class CreateTicketSupports < ActiveRecord::Migration[7.1]
  def change
    create_table :ticket_supports do |t|
      t.string :user_id
      t.string :sender
      t.string :content

      t.timestamps
    end
  end
end
