class CreateWalletIds < ActiveRecord::Migration[7.1]
  def change
    create_table :wallet_ids do |t|
      t.string :content
      t.float :money_buy
      t.float :reward

      t.timestamps
    end
  end
end
