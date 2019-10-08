class AddCourseAssignmentReferencesToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_reference :submissions, :course_assignment, null: false, foreign_key: true
  end
end
