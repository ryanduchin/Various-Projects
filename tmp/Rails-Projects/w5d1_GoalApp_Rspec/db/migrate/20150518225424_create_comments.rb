class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.string :commentable_type, null: false
      t.integer :commentable_id, null: false

      t.timestamps null: false
    end

    add_index :comments, [:commentable_type, :commentable_id], unique: true
  end
end
