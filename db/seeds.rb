# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
evan = User.create!(user_name: "Evan")
gregory = User.create!(user_name: "Gregory")
sarah = User.create!(user_name: "Sarah")
bill = User.create!(user_name: "Bill")
stanley = User.create!(user_name: "Stanley")
sally = User.create!(user_name: "Sally")

poll1 = Poll.create!(title: "General Preferences", author_id: evan.id)

q1 = Question.create!(text: 'What is your favorite color?', poll_id: poll1.id)
q2 = Question.create!(text: 'What is your favorite food?', poll_id: poll1.id)


q1a1 = AnswerChoice.create!(text: 'Red', question_id: q1.id)
q1a2 = AnswerChoice.create!(text: 'Blue', question_id: q1.id)

q2a1 = AnswerChoice.create!(text: 'chicken' , question_id: q2.id)
q2a2 = AnswerChoice.create!(text: 'beef', question_id: q2.id)

r1 = Response.create!(answer_choice_id: q1a1.id, respondent_id: sarah.id)
r2 = Response.create!(answer_choice_id: q2a1.id, respondent_id: sarah.id)

r3 = Response.create!(answer_choice_id: q1a2.id, respondent_id: gregory.id)
r4 = Response.create!(answer_choice_id: q2a2.id, respondent_id: gregory.id)

r5 = Response.create!(answer_choice_id: q1a2.id, respondent_id: stanley.id)
r6 = Response.create!(answer_choice_id: q1a2.id, respondent_id: bill.id)
r7 = Response.create!(answer_choice_id: q1a2.id, respondent_id: sally.id)
