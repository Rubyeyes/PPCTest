# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160208190836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "costs", force: :cascade do |t|
    t.float    "unitUSD"
    t.float    "toolingUSD"
    t.float    "unitRMB"
    t.float    "toolingRMB"
    t.text     "description"
    t.float    "ratio"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "costs", ["project_id"], name: "index_costs_on_project_id", using: :btree

  create_table "instructions", force: :cascade do |t|
    t.string   "instruction"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "instructions", ["project_id"], name: "index_instructions_on_project_id", using: :btree

  create_table "logos", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.text     "content"
    t.string   "item"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.boolean  "read"
    t.integer  "sender_id"
    t.integer  "recipient_id"
  end

  add_index "notifications", ["notifiable_id", "notifiable_type"], name: "index_notifications_on_notifiable_id_and_notifiable_type", using: :btree

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

  create_table "po_products", force: :cascade do |t|
    t.integer  "po_id"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "quantity"
    t.datetime "finish_date"
  end

  add_index "po_products", ["po_id"], name: "index_po_products_on_po_id", using: :btree
  add_index "po_products", ["product_id"], name: "index_po_products_on_product_id", using: :btree

  create_table "pos", force: :cascade do |t|
    t.string   "po_number"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "product_name"
    t.string   "item_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "project_id"
    t.text     "Instruction"
    t.text     "Mark"
    t.text     "Package"
    t.text     "reminder"
    t.integer  "cost_id"
    t.string   "logo_image"
    t.string   "patent_image"
    t.string   "made_image"
  end

  add_index "products", ["cost_id"], name: "index_products_on_cost_id", using: :btree
  add_index "products", ["project_id"], name: "index_products_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "project_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.text     "description"
    t.string   "image"
    t.string   "status"
    t.text     "problem"
    t.string   "patent_number"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
  end

  add_index "reports", ["project_id"], name: "index_reports_on_project_id", using: :btree

  create_table "role_options", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "samples", force: :cascade do |t|
    t.datetime "receive_date"
    t.integer  "quantity"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "samples", ["project_id"], name: "index_samples_on_project_id", using: :btree

  create_table "status_options", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "executor"
    t.text     "task"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "project_id"
    t.datetime "deadline"
    t.boolean  "finish"
    t.integer  "executor_id"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "role"
    t.string   "fullname"
    t.string   "locale"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "video"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "costs", "projects"
  add_foreign_key "instructions", "projects"
  add_foreign_key "po_products", "pos"
  add_foreign_key "po_products", "products"
  add_foreign_key "products", "costs"
  add_foreign_key "products", "projects"
  add_foreign_key "projects", "users"
  add_foreign_key "reports", "projects"
  add_foreign_key "samples", "projects"
  add_foreign_key "tasks", "projects"
end
