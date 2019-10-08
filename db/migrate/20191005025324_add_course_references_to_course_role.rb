class AddCourseReferencesToCourseRole < ActiveRecord::Migration[6.0]
  def change
    add_reference :course_roles, :course, null: false, foreign_key: true
  end
end
