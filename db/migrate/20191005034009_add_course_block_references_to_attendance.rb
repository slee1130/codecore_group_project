class AddCourseBlockReferencesToAttendance < ActiveRecord::Migration[6.0]
  def change
    add_reference :attendances, :course_block, null: false, foreign_key: true
  end
end
