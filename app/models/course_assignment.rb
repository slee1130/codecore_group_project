class CourseAssignment < ApplicationRecord
  has_many :submissions, dependent: :destroy

  belongs_to :course
  belongs_to :assignment
  
  before_validation :set_default_is_active

  # Returns the assignments that have been assigned and are past due
  def self.past
    CourseAssignment.where("assign_date < ? AND due_date < ?", Time.now, Time.now).order(:due_date)
  end

  # Return the assignments that haven't been assigned yet
  def self.upcoming
    CourseAssignment.where("assign_date > ?", Time.now).order(:due_date)
  end

  # Return the assignments that are due and
  def self.pending
    CourseAssignment.where("assign_date < ? AND due_date > ?", Time.now, Time.now).order(:due_date)
  end

  private

  def set_default_is_active
    self.is_active ||= true
  end
end
