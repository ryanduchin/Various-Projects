# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  respondent_id    :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :respondent_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_cant_respond_to_own_poll

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :respondent_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
    self.question.responses
      .where('? IS NULL OR responses.id != ?', self.id, self.id)
  end

  def respondent_has_not_already_answered_question
    if self.sibling_responses.where('respondent_id = ?', self.respondent_id).exists?
      errors[:respondent] << "has already answered this question"
    end
  end

  def respondent_cant_respond_to_own_poll
    if self.answer_choice.question.poll.author.id == self.respondent_id
      errors[:respondent] << "can't respond to their own poll"
    end
  end

end
