class CreateSlotGame333s < ActiveRecord::Migration[7.1]
  def change
    create_table :slot_game333s do |t|
      t.integer :user_id
      t.integer :num1
      t.integer :num2
      t.integer :num3
      t.float :reward
      t.float :price
      t.string :status

      t.timestamps
    end
  end
end
