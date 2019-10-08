class AddCourseRoleReferencesToAttendance < ActiveRecord::Migration[6.0]
  def change
    add_reference :attendances, :course_role, null: false, foreign_key: true
  end
end
