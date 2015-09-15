# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :poll_id, presence: true
  validates :text, presence: true

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many :responses, through: :answer_choices, source: :responses

  def results

    answers = answer_choices
      .select("answer_choices.text, COUNT(responses) AS response_ct")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .where("question_id = :id", id: id)
      .group("answer_choices.text")


    hash = {}
    answers.each {|answer| hash[answer.text] = answer.response_ct}
    hash
  end

end
