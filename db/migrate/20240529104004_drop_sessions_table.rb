class DropSessionsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :sessions
  end

  def down
    create_table :sessions do |t|
      t.string :session_token
      t.integer :user_id, null: false
      t.datetime :expires_at
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    add_index :sessions, :user_id, name: "index_sessions_on_user_id"
  end
end
