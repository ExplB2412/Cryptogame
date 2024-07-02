class CreateScratchGames < ActiveRecord::Migration[7.1]
  def change
    create_table :scratch_games do |t|
      t.float :reward
      t.integer :user_id
      t.float :price
      t.string :status

      t.timestamps
    end
  end
end
