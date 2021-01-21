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

ActiveRecord::Schema.define(version: 2020_12_11_004329) do

  create_table "areas", force: :cascade do |t|
    t.string "code", limit: 3
    t.string "name"
    t.boolean "active", default: true
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "title_id"
    t.boolean "active", default: true
  end

  create_table "entry_types", force: :cascade do |t|
    t.string "code"
    t.string "description"
  end

  create_table "job_areas", force: :cascade do |t|
    t.integer "job_id"
    t.integer "area_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "job_number"
    t.string "name"
    t.string "customer"
    t.integer "jobsite_id"
    t.boolean "active", default: true
  end

  create_table "jobsite_employees", force: :cascade do |t|
    t.integer "jobsite_id"
    t.integer "employee_id"
  end

  create_table "jobsites", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "state"
    t.boolean "active", default: true
  end

  create_table "tasks", force: :cascade do |t|
    t.string "code", limit: 3
    t.string "name"
    t.integer "jobsite_id"
    t.boolean "active", default: true
  end

  create_table "time_entries", force: :cascade do |t|
    t.datetime "workdate"
    t.integer "jobsite_id"
    t.integer "employee_id"
    t.integer "job_id"
    t.integer "area_id"
    t.integer "task_id"
    t.decimal "hours"
    t.integer "entry_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "titles", force: :cascade do |t|
    t.string "title"
  end

  create_table "user_jobsites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "jobsite_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "uid"
    t.string "provider"
    t.boolean "admin", default: false
  end

end
