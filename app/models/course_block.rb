class CourseBlock < ApplicationRecord
  has_many :attendances, dependent: :destroy
  belongs_to :course
  belongs_to :course_role

  validates(:course_block_type, presence: true)
  validates(:date, presence: true)
end
