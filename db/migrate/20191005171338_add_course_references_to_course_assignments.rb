class AddCourseReferencesToCourseAssignments < ActiveRecord::Migration[6.0]
  def change
    add_reference :course_assignments, :course, null: false, foreign_key: true
  end
end
