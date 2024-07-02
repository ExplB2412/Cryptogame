class CreateDeposits < ActiveRecord::Migration[7.1]
  def change
    create_table :deposits do |t|
      t.string :user_id
      t.string :wallet_id
      t.string :status
      t.string :deposit_address
      t.string :invoice
      t.float :amount

      t.timestamps
    end
  end
end
