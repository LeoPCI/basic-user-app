# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190129034834) do

  create_table "activities", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "activation"
    t.text "participants"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activities_users", id: false, force: :cascade do |t|
    t.integer "activity_id", null: false
    t.integer "user_id", null: false
    t.index ["activity_id", "user_id"], name: "index_activities_users_on_activity_id_and_user_id"
    t.index ["user_id", "activity_id"], name: "index_activities_users_on_user_id_and_activity_id"
  end

  create_table "cridissents", force: :cascade do |t|
    t.string "title"
    t.integer "criterium_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criterium_id"], name: "index_cridissents_on_criterium_id"
    t.index ["user_id"], name: "index_cridissents_on_user_id"
  end

  create_table "criteria", force: :cascade do |t|
    t.string "title"
    t.text "alternatives"
    t.integer "problem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_criteria_on_problem_id"
    t.index [nil, nil], name: "dissenters"
  end

  create_table "criteria_users", id: false, force: :cascade do |t|
    t.integer "criterium_id", null: false
    t.integer "user_id", null: false
    t.index ["user_id", nil], name: "index_criteria_users_on_user_id_and_criteria_id"
    t.index [nil, "user_id"], name: "index_criteria_users_on_criteria_id_and_user_id"
  end

  create_table "polls", force: :cascade do |t|
    t.integer "answer"
    t.integer "criterium_id"
    t.integer "solution_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criterium_id"], name: "index_polls_on_criterium_id"
    t.index ["solution_id"], name: "index_polls_on_solution_id"
    t.index ["user_id"], name: "index_polls_on_user_id"
  end

  create_table "problems", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "problems_users", id: false, force: :cascade do |t|
    t.integer "problem_id", null: false
    t.integer "user_id", null: false
    t.index ["problem_id", "user_id"], name: "index_problems_users_on_problem_id_and_user_id"
    t.index ["user_id", "problem_id"], name: "index_problems_users_on_user_id_and_problem_id"
  end

  create_table "rolls", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "minimum"
    t.integer "maximum"
    t.integer "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_rolls_on_activity_id"
  end

  create_table "rolls_users", id: false, force: :cascade do |t|
    t.integer "roll_id", null: false
    t.integer "user_id", null: false
    t.index ["roll_id", "user_id"], name: "index_rolls_users_on_roll_id_and_user_id"
    t.index ["user_id", "roll_id"], name: "index_rolls_users_on_user_id_and_roll_id"
  end

  create_table "solutions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "problem_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id", "created_at"], name: "index_solutions_on_problem_id_and_created_at"
    t.index ["problem_id"], name: "index_solutions_on_problem_id"
    t.index ["user_id"], name: "index_solutions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
  end

end
