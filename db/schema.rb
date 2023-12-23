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

ActiveRecord::Schema[7.0].define(version: 2023_12_23_075305) do
  create_table "articles", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", default: "", null: false
    t.integer "word_count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "basic_train_data", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "answer_count"
    t.integer "right_count"
    t.integer "reaction_time"
    t.bigint "word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_id"], name: "index_basic_train_data_on_word_id"
  end

  create_table "words", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "part_of_speech"
    t.integer "real_frequency", default: 0, null: false
    t.float "stat_frequency", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pronunciation", null: false
    t.string "meaning", default: ""
    t.boolean "reported", default: false
    t.index ["stat_frequency"], name: "index_words_on_stat_frequency"
  end

  add_foreign_key "basic_train_data", "words"
end
