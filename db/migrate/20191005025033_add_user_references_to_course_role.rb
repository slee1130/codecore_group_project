class AddUserReferencesToCourseRole < ActiveRecord::Migration[6.0]
  def change
    add_reference :course_roles, :user, null: false, foreign_key: true
  end
end
