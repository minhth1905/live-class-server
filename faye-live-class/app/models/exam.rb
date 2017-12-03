class Exam < ApplicationRecord
  has_many :questions
  belongs_to :grade
  after_create :create_question

  def create_question
    require 'net/http'

    uri = URI('http://104.197.170.13:4200/api/liveClass?token=VFA4bTM0ckNWa2cyNlU3YjJiT0ZkRlJVeHFJZ3hMSmJ0OUZT')
    res = Net::HTTP.get_response(uri)
    data = JSON.parse(res.body)
    question_all = data["questions"] rescue nil

    if question_all.present?

      Question.bulk_insert do |worker|
        question_all.each do |question|
          string_url = "http://104.197.170.13:4200/api/liveClass/#{question}?token=VFA4bTM0ckNWa2cyNlU3YjJiT0ZkRlJVeHFJZ3hMSmJ0OUZT"
          uri_question = URI(string_url)
          res_question = Net::HTTP.get_response(uri_question)
          data_question = JSON.parse(res_question.body)
          # byebug
          content = data_question["question"]["content"]
          dap_an = "A"
          data_question["question"]["answers"].each_with_index do |answer, index|
            case index
            when 0
              chi_so = "A"
            when 1
              chi_so = "B"
            when 2
              chi_so = "C"
            when 3
              chi_so = "D"
            end

            if data_question["question"]["trueAnswer"] == answer["id"]
              case index
              when 0
                dap_an = "A"
              when 1
                dap_an = "B"
              when 2
                dap_an = "C"
              when 3
                dap_an = "D"
              end
            end

            content = content + "<p>#{chi_so}. #{answer["answer"]} </p>"
          end
          worker.add(id_mongo: question, exam_id: self.id, content: content, answer: dap_an)
        end
      end

      questions_db = Question.where(exam_id: self.id)
      students = Student.all

      AnswerQuestion.bulk_insert do |worker|
        students.each do |student|
          questions_db.each do |question|
            worker.add(question_id: question.id, student_id: student.id)
          end
        end
      end
    end

  end
end
