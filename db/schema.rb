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

ActiveRecord::Schema.define(version: 2019_10_07_023900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
  end

  create_table "attendances", force: :cascade do |t|
    t.boolean "is_present"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "course_role_id", null: false
    t.bigint "course_block_id", null: false
    t.index ["course_block_id"], name: "index_attendances_on_course_block_id"
    t.index ["course_role_id"], name: "index_attendances_on_course_role_id"
  end

  create_table "course_assignments", force: :cascade do |t|
    t.datetime "assign_date"
    t.datetime "due_date"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "assignment_id", null: false
    t.bigint "course_id", null: false
    t.bigint "course_role_assigner_id"
    t.integer "maximum_score"
    t.index ["assignment_id"], name: "index_course_assignments_on_assignment_id"
    t.index ["course_id"], name: "index_course_assignments_on_course_id"
  end

  create_table "course_blocks", force: :cascade do |t|
    t.date "date"
    t.string "course_block_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "course_id", null: false
    t.bigint "course_role_id", null: false
    t.index ["course_id"], name: "index_course_blocks_on_course_id"
    t.index ["course_role_id"], name: "index_course_blocks_on_course_role_id"
  end

  create_table "course_roles", force: :cascade do |t|
    t.string "role"
    t.boolean "is_archived"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.index ["course_id"], name: "index_course_roles_on_course_id"
    t.index ["user_id"], name: "index_course_roles_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "status"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_archived"
    t.bigint "program_id", null: false
    t.index ["program_id"], name: "index_courses_on_program_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.datetime "submission_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "course_role_submitter_id"
    t.bigint "course_role_marker_id"
    t.bigint "course_assignment_id", null: false
    t.text "feedback"
    t.integer "score"
    t.string "submission_url"
    t.index ["course_assignment_id"], name: "index_submissions_on_course_assignment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "img_url"
    t.boolean "is_admin"
  end

  add_foreign_key "attendances", "course_blocks"
  add_foreign_key "attendances", "course_roles"
  add_foreign_key "course_assignments", "assignments"
  add_foreign_key "course_assignments", "course_roles", column: "course_role_assigner_id"
  add_foreign_key "course_assignments", "courses"
  add_foreign_key "course_blocks", "course_roles"
  add_foreign_key "course_blocks", "courses"
  add_foreign_key "course_roles", "courses"
  add_foreign_key "course_roles", "users"
  add_foreign_key "courses", "programs"
  add_foreign_key "submissions", "course_assignments"
  add_foreign_key "submissions", "course_roles", column: "course_role_marker_id"
  add_foreign_key "submissions", "course_roles", column: "course_role_submitter_id"
end
