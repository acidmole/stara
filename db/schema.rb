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

ActiveRecord::Schema[7.0].define(version: 2023_11_03_081356) do
  create_table "competitions", force: :cascade do |t|
    t.string "name"
    t.string "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
  end

  create_table "games", force: :cascade do |t|
    t.date "game_day"
    t.time "game_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "competition_id"
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.boolean "played", default: false
    t.index ["away_team_id"], name: "index_games_on_away_team_id"
    t.index ["competition_id"], name: "index_games_on_competition_id"
    t.index ["home_team_id"], name: "index_games_on_home_team_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "game_id"
    t.integer "home_team_score"
    t.integer "away_team_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_results_on_game_id"
  end

  create_table "rosters", force: :cascade do |t|
    t.integer "team_id", null: false
    t.string "players"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "standings", force: :cascade do |t|
    t.integer "games"
    t.integer "wins"
    t.integer "losses"
    t.integer "scored_for"
    t.integer "scored_against"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "competition_id"
    t.integer "team_id"
    t.index ["competition_id"], name: "index_standings_on_competition_id"
    t.index ["team_id"], name: "index_standings_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "competitions"
  add_foreign_key "games", "teams", column: "away_team_id"
  add_foreign_key "games", "teams", column: "home_team_id"
  add_foreign_key "results", "games"
  add_foreign_key "standings", "competitions"
  add_foreign_key "standings", "teams"
end
