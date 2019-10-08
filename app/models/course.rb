class Course < ApplicationRecord
  belongs_to :program
  has_many :course_roles, dependent: :destroy
  has_many :course_blocks, dependent: :destroy
  has_many :course_assignments, dependent: :destroy
  has_many :users, through: :course_roles

  before_validation :set_default_status
  before_validation :set_default_is_archived

  validates(:name, presence: true)

  def instructors
    self.course_roles.where(role: "instructor").map(&:user)
  end

  def enrolled
    self.course_roles.where(role: "student").map(&:user)
  end

  def markers
    self.course_assignments.map(&:submissions).flatten.inject([]) { |acc,submission|
      acc << CourseRole.find(submission.course_role_marker_id).user if submission.course_role_marker_id
      acc.uniq
    }
  end

  private

  def set_default_status
    self.status ||= "new"
  end

  def set_default_is_archived
    self.is_archived ||= false
  end
end

