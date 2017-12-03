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

User.create(email: "demo@gmail.com", password: "12345678", password_confirmation: "12345678")

#grade
Grade.create(name: "Kiểm thử và đảm bảo chất lượng phần mềm", node: "node 1")

students = []
File.open("#{Rails.root}/docs/Danh_sach_sinh_vien.csv").each_line do |line|
  students.push line.gsub("\n", "").split("|")
end
students.each do |student|
  Student.create(name: student[1], marker_id: student[0], grade_id: Grade.first.id)
end

1.upto(5) do |i|
  Exam.create(name: "Bài kiểm tra số #{i}", grade_id: Grade.first.id)
end
