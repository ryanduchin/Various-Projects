class FixIndices < ActiveRecord::Migration
  def change
    remove_index :polls, :author_id
    remove_index :questions, :poll_id
    remove_index :answer_choices, :question_id
    remove_index :responses, :answer_choice_id
    remove_index :responses, :respondent_id

    add_index :polls, :author_id
    add_index :questions, :poll_id
    add_index :answer_choices, :question_id
    add_index :responses, :answer_choice_id
    add_index :responses, :respondent_id

  end
end
