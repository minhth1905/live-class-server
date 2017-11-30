class Api::V1::QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
   @question = "<p><b>Câu hỏi #{@type}:</b></p> \
    <p>Có 1 trường trong form chứa 1 textbox cho phép nhập các kí tự in hoa hoặc là in thường. Đầu vào nào sau đây không hợp lệ</p>\
    <p>A. $5800, $28000, $32000</p>\
    <p>B. $4800,  $14000, $28000</p>\
    <p>C. $5200,  $5500, $28000</p>\
    <p>D. $28001, $32000, $35000</p>\
    ".html_safe
    render json: {code: 1, data: @question}
  end
end
