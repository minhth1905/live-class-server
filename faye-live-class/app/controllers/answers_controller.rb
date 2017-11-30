class AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @answers = Answer.all
  end

  def create
    @answer = AnswerQuestion.joins(:student)
                .where("students.marker_id = ?", params[:marker_id])
                .where("answer_questions.question_id = ?", params[:question_id]).first
    if @answer.present?
      if @answer.content != model_params[:content]
        @answer.assign_attributes model_params
        @answer.save
        PrivatePub.publish_to("/next_pages/new", message: @answer, type: "answer")
      end
    end
    render json: {code: 1}, status: :ok
  end

  def update
    Answer.update_all(content: nil)
    redirect_to root_path
  end

  private
  def model_params
    params.permit :content
  end

end
