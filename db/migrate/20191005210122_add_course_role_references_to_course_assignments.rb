class AddCourseRoleReferencesToCourseAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :course_assignments, :course_role_assigner_id, :bigint, index: true
    add_foreign_key :course_assignments, :course_roles, column: :course_role_assigner_id
  end
end