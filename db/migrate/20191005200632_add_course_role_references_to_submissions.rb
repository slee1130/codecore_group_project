class AddCourseRoleReferencesToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :course_role_submitter_id, :bigint, index: true
    add_foreign_key :submissions, :course_roles, column: :course_role_submitter_id
    add_column :submissions, :course_role_marker_id, :bigint, index: true
    add_foreign_key :submissions, :course_roles, column: :course_role_marker_id
  end
end