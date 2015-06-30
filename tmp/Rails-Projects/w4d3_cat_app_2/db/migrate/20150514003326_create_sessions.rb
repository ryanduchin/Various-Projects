class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :session_token NOT NULL
      t.integer :user_id NOT NULL

      t.timestamps
    end
  end

  add_index :sessions, :session_token, unique: true
  add_index :sessions, :user_id
end
