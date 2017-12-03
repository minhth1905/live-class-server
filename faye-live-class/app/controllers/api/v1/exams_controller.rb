class Api::V1::ExamsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @exams = Exam.all
    render json: {code: 1, data: @exams}
  end

  def show
    questions = Question.where(exam_id: params[:id]).order(id: :asc)
    render json: {code: 1, data: questions}
  end
end
