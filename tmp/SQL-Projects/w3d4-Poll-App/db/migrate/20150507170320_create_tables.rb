class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false, unique: true

      t.timestamps
    end

    create_table :polls do |t|
      t.string :title, null: false
      t.integer :author_id, null: false

      t.timestamps
    end

    create_table :questions do |t|
      t.text :text, null: false
      t.integer :poll_id, null: false

      t.timestamps
    end

    create_table :answer_choices do |t|
      t.text :text, null: false
      t.integer :question_id, null: false

      t.timestamps
    end

    create_table :responses do |t|
      t.integer :respondent_id, null: false
      t.integer :answer_choice_id, null: false

      t.timestamps
    end
  end
end
