class NextPagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    exam_id = params[:exam_id]
    question_id = params[:question_id]
    @data = "#{exam_id}_#{question_id}"
    PrivatePub.publish_to("/next_pages/new", message: @data, type: "redirect")
    render json: {code: 1}, status: :ok
  end

  def show
    PrivatePub.publish_to("/next_pages/new", message: "haha")
  end
end
