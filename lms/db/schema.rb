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

ActiveRecord::Schema.define(version: 20170610152615) do

  create_table "answers", force: :cascade do |t|
    t.string   "option"
    t.string   "image"
    t.boolean  "correct_answer"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "question_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "assessment_type"
    t.boolean  "passing_criteria"
    t.float    "passing_percentage",            default: 0.0
    t.integer  "number_of_displayed_questions"
    t.boolean  "upfront"
    t.boolean  "additional_text"
    t.boolean  "details_page"
    t.boolean  "randomize"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "course_section_id"
    t.index ["course_section_id"], name: "index_assessments_on_course_section_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "certificates", force: :cascade do |t|
    t.string "name"
    t.string "file"
    t.text   "short_description"
    t.text   "description"
  end

  create_table "course_sections", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "course_order"
    t.integer  "chapter_order"
    t.boolean  "content",       default: false
    t.boolean  "is_assessment", default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "version_id"
    t.index ["version_id"], name: "index_course_sections_on_version_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses_certificates", id: false, force: :cascade do |t|
    t.integer "certificate_id"
    t.integer "course_id"
    t.index ["certificate_id"], name: "index_courses_certificates_on_certificate_id"
    t.index ["course_id"], name: "index_courses_certificates_on_course_id"
  end

  create_table "custom_contents", force: :cascade do |t|
    t.string   "title"
    t.string   "zip"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "course_section_id"
    t.index ["course_section_id"], name: "index_custom_contents_on_course_section_id"
  end

  create_table "evaluation_questions", force: :cascade do |t|
    t.string   "content"
    t.boolean  "active"
    t.integer  "course_order"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "version_id"
    t.index ["version_id"], name: "index_evaluation_questions_on_version_id"
  end

  create_table "interactive_slides", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "version_id"
    t.integer  "course_section_id"
    t.index ["course_section_id"], name: "index_interactive_slides_on_course_section_id"
    t.index ["version_id"], name: "index_interactive_slides_on_version_id"
  end

  create_table "interactive_slides_informations", force: :cascade do |t|
    t.string   "image"
    t.string   "title"
    t.text     "description"
    t.string   "type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "interactive_slide_id"
    t.index ["interactive_slide_id"], name: "index_interactive_slides_informations_on_interactive_slide_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "permission_name"
    t.string   "title"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "presentations", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "course_section_id"
    t.index ["course_section_id"], name: "index_presentations_on_course_section_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text     "title"
    t.text     "additional_text"
    t.integer  "question_order"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "question_category_id"
    t.integer  "assessment_id"
    t.index ["assessment_id"], name: "index_questions_on_assessment_id"
    t.index ["question_category_id"], name: "index_questions_on_question_category_id"
  end

  create_table "questions_categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "resources", force: :cascade do |t|
    t.string   "title"
    t.string   "file"
    t.string   "type"
    t.string   "description"
    t.text     "content"
    t.integer  "chapter_order"
    t.integer  "version_order"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "course_section_id"
    t.integer  "content_section_id"
    t.integer  "version_id"
    t.index ["content_section_id"], name: "index_resources_on_content_section_id"
    t.index ["course_section_id"], name: "index_resources_on_course_section_id"
    t.index ["version_id"], name: "index_resources_on_version_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role_name"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_permissions", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "permission_id"
    t.index ["permission_id"], name: "index_roles_permissions_on_permission_id"
    t.index ["role_id"], name: "index_roles_permissions_on_role_id"
  end

  create_table "slide_settings", force: :cascade do |t|
    t.string   "background_color", default: "#fffff"
    t.string   "background_image"
    t.string   "transition"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "slide_id"
    t.index ["slide_id"], name: "index_slide_settings_on_slide_id"
  end

  create_table "slides", force: :cascade do |t|
    t.string   "title"
    t.integer  "number_of_columns", limit: 2
    t.integer  "slides_order"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "presentation_id"
    t.index ["presentation_id"], name: "index_slides_on_presentation_id"
  end

  create_table "slides_contents", force: :cascade do |t|
    t.text     "content"
    t.string   "orientation"
    t.string   "file_url"
    t.string   "type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "slide_id"
    t.index ["slide_id"], name: "index_slides_contents_on_slide_id"
  end

  create_table "test1", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.string   "video"
    t.integer  "roll_no"
    t.float    "price"
    t.boolean  "correct_answer"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "test2", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.boolean  "gender"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "birthdate"
    t.integer  "test1_id"
    t.index ["test1_id"], name: "index_test2_on_test1_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "version",                                   default: "0"
    t.text     "short_description"
    t.text     "description",                                               null: false
    t.string   "image"
    t.string   "video"
    t.integer  "expiry"
    t.boolean  "price"
    t.decimal  "amount",            precision: 5, scale: 2
    t.string   "default_image"
    t.integer  "prerequisite"
    t.boolean  "editable",                                  default: true
    t.boolean  "published",                                 default: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "course_id"
    t.integer  "category_id"
    t.index ["category_id"], name: "index_versions_on_category_id"
    t.index ["course_id"], name: "index_versions_on_course_id"
  end

  create_table "versions_roles", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "version_id"
    t.index ["role_id"], name: "index_versions_roles_on_role_id"
    t.index ["version_id"], name: "index_versions_roles_on_version_id"
  end

end
