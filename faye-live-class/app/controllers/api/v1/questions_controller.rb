class Api::V1::QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @type = params[:id]
    check_question = Question.find_by(id: @type)
    if check_question.blank?
      render json: {code: 1, data: nil}
      return
    end
    @question = check_question.content.html_safe
    render json: {code: 1, data: @question}
  end
end
