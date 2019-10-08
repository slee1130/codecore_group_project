class CourseRole < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_many :course_blocks, dependent: :destroy

  belongs_to :user
  belongs_to :course

  validates(:role, presence: true)

  before_validation :set_default_is_archived

  private

  def set_default_is_archived
    self.is_archived ||= false
  end
end
