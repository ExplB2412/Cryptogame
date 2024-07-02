# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_01_073613) do
  create_table "deposits", force: :cascade do |t|
    t.string "user_id"
    t.string "wallet_id"
    t.string "status"
    t.string "deposit_address"
    t.string "invoice"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "history_wallets", force: :cascade do |t|
    t.string "wallet_id"
    t.string "content"
    t.float "money_buy"
    t.float "reward"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "horseracings", force: :cascade do |t|
    t.integer "user_id"
    t.string "horse_buy"
    t.string "top1"
    t.string "top2"
    t.string "top3"
    t.string "top4"
    t.string "speed1"
    t.string "speed2"
    t.string "speed3"
    t.string "speed4"
    t.string "status"
    t.float "price"
    t.float "reward"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scratch_games", force: :cascade do |t|
    t.float "reward"
    t.integer "user_id"
    t.float "price"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scratch_playings", force: :cascade do |t|
    t.integer "user_id"
    t.string "total_play"
    t.string "total_winning"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slot_game333s", force: :cascade do |t|
    t.integer "user_id"
    t.integer "num1"
    t.integer "num2"
    t.integer "num3"
    t.float "reward"
    t.float "price"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_supports", force: :cascade do |t|
    t.string "user_id"
    t.string "sender"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "ip"
    t.string "securitykey"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallet_ids", force: :cascade do |t|
    t.string "content"
    t.float "money_buy"
    t.float "reward"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "user_id"
    t.string "wallet_type"
    t.float "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "withdraws", force: :cascade do |t|
    t.string "user_id"
    t.string "wallet_id"
    t.string "status"
    t.string "withdraw_address"
    t.float "amount"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
