class CreateHorseracings < ActiveRecord::Migration[7.1]
  def change
    create_table :horseracings do |t|
      t.integer :user_id
      t.string :horse_buy
      t.string :top1
      t.string :top2
      t.string :top3
      t.string :top4
      t.string :speed1
      t.string :speed2
      t.string :speed3
      t.string :speed4
      t.string :status
      t.float :price
      t.float :reward

      t.timestamps
    end
  end
end
