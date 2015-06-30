class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.string :body
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :goals, :user_id
  end
end
