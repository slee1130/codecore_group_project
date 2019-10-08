class Attendance < ApplicationRecord
  belongs_to :course_block
  belongs_to :course_role

  before_validation :set_default_is_present

  private

  def set_default_is_present
    self.is_present ||= true
  end
end