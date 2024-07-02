class CreateScratchPlayings < ActiveRecord::Migration[7.1]
  def change
    create_table :scratch_playings do |t|
      t.integer :user_id
      t.string :total_play
      t.string :total_winning

      t.timestamps
    end
  end
end
