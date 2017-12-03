class NextPagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    exam_id = params[:exam_id]
    question_id = params[:question_id]
    question = Question.find_by(id: question_id)
    if question.present?
      exam_id = question.exam_id
    end
    type = params[:show_answer]
    if type.present?
      type = "show_answer"
    else
      type = "redirect"
    end

    @data = "#{exam_id}_#{question_id}"
    PrivatePub.publish_to("/next_pages/new", message: @data, type: type)
    render json: {code: 1}, status: :ok
  end

  def show
    PrivatePub.publish_to("/next_pages/new", message: "haha")
  end
end
