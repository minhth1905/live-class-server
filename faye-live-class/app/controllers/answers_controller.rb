class AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @answers = Answer.all
  end

  def create
    @answer = Answer.find_by(marker_id: params[:marker_id])
    if @answer.present?
      if @answer.content != model_params[:content]
        @answer.assign_attributes model_params
        @answer.save
        PrivatePub.publish_to("/answers/new", message: @answer)
      end
    end
    render json: {code: 1}, status: :ok
  end

  private
  def model_params
    params.permit :content
  end

end
