class ExamsController < ApplicationController
  def index
    @exams = Exam.all
  end

  def show
    @type = params[:type]

    @questions = Question.where(exam_id: params[:id])
    if @type != "home"
      check_question = Question.find_by(id: @type)
      if check_question.blank?
        redirect_to root_path
      end
      @question = "<p><b>Câu hỏi #{@type}:</b></p> \
      <p>Có 1 trường trong form chứa 1 textbox cho phép nhập các kí tự in hoa hoặc là in thường. Đầu vào nào sau đây không hợp lệ</p>\
      <p>A. $5800, $28000, $32000</p>\
      <p>B. $4800,  $14000, $28000</p>\
      <p>C. $5200,  $5500, $28000</p>\
      <p>D. $28001, $32000, $35000</p>\
      ".html_safe

      @students = Student.select("students.*", "answer_questions.*")
        .joins("left join answer_questions
        on students.id = answer_questions.student_id")
        .where("answer_questions.question_id = ?", @type)

      if params[:show_answer].present?
        @answer_true = check_question.answer
      else
        @answer_true = nil
      end
    end
  end
end
