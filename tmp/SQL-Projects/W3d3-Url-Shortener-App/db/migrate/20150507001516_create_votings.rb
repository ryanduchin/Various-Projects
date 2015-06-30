class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.integer :user_id, null: false
      t.integer :shortened_url_id, null: false
      t.integer :vote_value

      t.timestamps
    end
    add_index :votings, :shortened_url_id
    add_index :votings, :user_id
  end
end
