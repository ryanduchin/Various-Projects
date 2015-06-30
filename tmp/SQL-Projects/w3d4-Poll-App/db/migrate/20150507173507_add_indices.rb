class AddIndices < ActiveRecord::Migration
  def change
    change_column :users, :name, :string, null: false, unique: false

    add_index :users, :name, unique: true
    add_index :polls, :author_id, unique: true
    add_index :questions, :poll_id, unique: true
    add_index :answer_choices, :question_id, unique: true
    add_index :responses, :answer_choice_id, unique: true
    add_index :responses, :respondent_id, unique: true
  end
end
