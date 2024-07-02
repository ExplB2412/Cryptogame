class CreateWithdraws < ActiveRecord::Migration[7.1]
  def change
    create_table :withdraws do |t|
      t.string :user_id
      t.string :wallet_id
      t.string :status
      t.string :withdraw_address
      t.float :amount
      t.string :note

      t.timestamps
    end
  end
end
