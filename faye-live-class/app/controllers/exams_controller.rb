class ExamsController < ApplicationController
  before_action :authenticate_user!
  def index
    @exams = Exam.all
  end

  def create
    begin
      indexs = Exam.count

      Exam.create(name: "Bài kiểm tra số #{indexs + 1}", grade_id: Grade.first.id)
      redirect_to exams_path
    rescue
      redirect_to exams_path
    end
  end

  def show
    @type = params[:type]

    @questions = Question.where(exam_id: params[:id]).order(id: :asc)
    if @type != "home"
      check_question = Question.find_by(id: @type)
      if check_question.blank?
        redirect_to root_path
      end
      @question = check_question.content.html_safe

      @students = Student.select("students.*", "answer_questions.question_id" ,
        "answer_questions.student_id", "answer_questions.content")
        .joins("left join answer_questions
        on students.id = answer_questions.student_id")
        .where("answer_questions.question_id = ?", @type)

      if params[:show_answer].present?
        @answer_true = check_question.answer
        @answer_question = check_question.answer
        @true_answer = AnswerQuestion.where(question_id: @type, content: @answer_question).count
        @wrong_answer = AnswerQuestion.where(question_id: @type).where("content != ? and content is not null", @answer_question).count
        @not_answer = AnswerQuestion.where(question_id: @type).where("content is null", @answer_question).count
      else
        @answer_true = nil
      end
    end
  end
end
