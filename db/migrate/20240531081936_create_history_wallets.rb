class CreateHistoryWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :history_wallets do |t|
      t.string :wallet_id
      t.string :content
      t.float :money_buy
      t.float :reward

      t.timestamps
    end
  end
end
