class CreateWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :wallets do |t|
      t.integer :user_id
      t.string :wallet_type
      t.float :balance

      t.timestamps
    end
  end
end
