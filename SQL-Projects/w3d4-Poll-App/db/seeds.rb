# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.new(name: "user1")
user2 = User.new(name: "user2")
user1.save!
user2.save!

poll1 = Poll.new(title: "Poll1", author_id: user1.id)
poll1.save!

question1 = Question.new(text: "This is question 1?", poll_id: poll1.id)
question2 = Question.new(text: "this is question 2?", poll_id: poll1.id)

question1.save!
question2.save!

choice1 = AnswerChoice.new(text: "choice 1", question_id: question1.id)
choice2 = AnswerChoice.new(text: "choice 2", question_id: question1.id)
choice3 = AnswerChoice.new(text: "choice 3", question_id: question2.id)
choice4 = AnswerChoice.new(text: "choice 4", question_id: question2.id)

[choice1, choice2, choice3, choice4].each { |choice| choice.save! }

response1 = Response.new(respondent_id: user2.id, answer_choice_id: choice1.id)
