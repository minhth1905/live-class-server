class Student < ApplicationRecord
  belongs_to :grade
  has_many :answer_questions
end
