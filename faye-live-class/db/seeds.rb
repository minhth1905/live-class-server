# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Answer.delete_all
# 1.upto(20) do |i|
#   full_name = Faker::Name.name
#   Answer.create!(marker_id: i, full_name: full_name)
# end

User.create(email: "admin@gmail.com", password: "12345678", password_confirmation: "12345678")

#grade
Grade.create(name: "Kiểm thử và đảm bảo chất lượng phần mềm", node: "node 1")

Exam.create(name: "Bài kiểm tra số 1", grade_id: Grade.first.id)
Exam.create(name: "Bài kiểm tra số 2", grade_id: Grade.first.id)

1.upto(10) do |i|
  Question.create(id_mongo: "question#{i}", exam_id: Exam.first.id, answer: "A")
end

1.upto(10) do |i|
  Question.create(id_mongo: "question#{i}", exam_id: Exam.second.id, answer: "A")
end

1.upto(80) do |i|
  Student.create(name: Faker::Name.name, marker_id: i, grade_id: Grade.first.id)
end

Student.all.each do |student|
  Question.all.each do |question|
    check = AnswerQuestion.where(student_id: student.id, question_id: question.id)
    if check.blank?
      AnswerQuestion.create(student_id: student.id, question_id: question.id)
    end
  end
end
