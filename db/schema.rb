# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_15_124036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "boards", force: :cascade do |t|
    t.float "posX"
    t.float "posY"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_boards_on_game_id"
  end

  create_table "card_decks", force: :cascade do |t|
    t.float "posX"
    t.float "posY"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_card_decks_on_game_id"
  end

  create_table "cards", force: :cascade do |t|
    t.float "posX"
    t.float "posY"
    t.bigint "card_deck_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_deck_id"], name: "index_cards_on_card_deck_id"
  end

  create_table "dice_trays", force: :cascade do |t|
    t.float "posX"
    t.float "posY"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_dice_trays_on_game_id"
  end

  create_table "dices", force: :cascade do |t|
    t.float "posX"
    t.float "posY"
    t.bigint "dice_tray_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dice_tray_id"], name: "index_dices_on_dice_tray_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "pieces", force: :cascade do |t|
    t.float "posX"
    t.float "posY"
    t.bigint "pieces_tray_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pieces_tray_id"], name: "index_pieces_on_pieces_tray_id"
  end

  create_table "pieces_trays", force: :cascade do |t|
    t.float "posX"
    t.float "posY"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_pieces_trays_on_game_id"
  end

  create_table "tiles", force: :cascade do |t|
    t.float "posX"
    t.float "posY"
    t.bigint "board_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["board_id"], name: "index_tiles_on_board_id"
  end

  create_table "token_trays", force: :cascade do |t|
    t.float "posX"
    t.float "posY"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_token_trays_on_game_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.float "posX"
    t.float "posY"
    t.bigint "token_tray_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token_tray_id"], name: "index_tokens_on_token_tray_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "about"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "boards", "games"
  add_foreign_key "card_decks", "games"
  add_foreign_key "cards", "card_decks"
  add_foreign_key "dice_trays", "games"
  add_foreign_key "dices", "dice_trays"
  add_foreign_key "games", "users"
  add_foreign_key "pieces", "pieces_trays"
  add_foreign_key "pieces_trays", "games"
  add_foreign_key "tiles", "boards"
  add_foreign_key "token_trays", "games"
  add_foreign_key "tokens", "token_trays"
end
