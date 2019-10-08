class AddCourseRoleReferencesToCourseBlock < ActiveRecord::Migration[6.0]
  def change
    add_reference :course_blocks, :course_role, null: false, foreign_key: true
  end
end
