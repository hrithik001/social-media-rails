

ActiveRecord::Schema[7.1].define(version: 2024_05_29_060939) do
  create_table "active_sessions", force: :cascade do |t|
    t.string "session_id"
    t.integer "user_id", null: false
    t.string "status"
    t.datetime "session_expiry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_active_sessions_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_token"
    t.integer "user_id", null: false
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_sessions", "users"
  add_foreign_key "sessions", "users"
end
