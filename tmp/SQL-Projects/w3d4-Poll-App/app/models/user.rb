# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :name, presence: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :respondent_id,
    primary_key: :id
  )

  # def completed_polls
  #
  # end
# RAW SQL
#questions per poll
def check_sql
  User.find_by_sql(
  [

    "SELECT
      *
    FROM
    --questions per poll
      (SELECT
        polls.*, COUNT(questions.id) AS question_count
      FROM
        polls
      JOIN
        questions ON questions.poll_id = polls.id
      GROUP BY
        polls.id
      ) AS polls

    JOIN (
    --responses, from this user, per poll
      SELECT
        questions.*, COUNT(responses.id) AS responses_count
      FROM
        questions
      JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN
        (SELECT
          *
        FROM
          responses
        WHERE
          responses.respondent_id = ?
        ) ON answer_choices.id = responses.answer_choice_id
      GROUP BY
        questions.poll_id
      ) ON polls.id = questions.poll_id --problem is in this questions.poll_id
    WHERE
      question_count = responses_count",

  self.id])
end
end
