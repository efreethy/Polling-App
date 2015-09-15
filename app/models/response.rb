# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer
#  respondent_id    :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :respondent_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cant_answer_own_question

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :respondent_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question

  private
  def author_cant_answer_own_question
    if question.poll.author_id == respondent_id
      errors[:base] << "Author can't respond to own poll"
    end
  end

  def respondent_has_not_already_answered_question
    unless sibling_responses.where(respondent_id: self.respondent_id).empty?
      errors[:base] << "One user can't answer the same question twice"
    end
  end

  def sibling_responses
    question.responses.where.not(id:  self.id)
  end
end
