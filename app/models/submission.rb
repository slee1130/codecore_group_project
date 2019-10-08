class Submission < ApplicationRecord
  belongs_to :course_assignment

  validates(:submission_date, presence: true)

  def submitter
    CourseRole.find(self.course_role_submitter_id).user
  end

  def marker
    CourseRole.find(self.course_role_marker_id).user
  end

  def grade
    if self.course_assignment.maximum_score == 1
      self.score == 1 ? "pass" : "fail"
    else
      ((self.score.to_f / self.course_assignment.maximum_score.to_f) * 100).round(2)
    end
  end

  def course
    self.course_assignment.course
  end

  def max_score
    self.course_assignment.maximum_score
  end

end
