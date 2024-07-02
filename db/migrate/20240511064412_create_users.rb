class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :ip
      t.string :securitykey

      t.timestamps
    end
  end
end
