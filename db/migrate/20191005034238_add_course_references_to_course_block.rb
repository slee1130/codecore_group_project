class AddCourseReferencesToCourseBlock < ActiveRecord::Migration[6.0]
  def change
    add_reference :course_blocks, :course, null: false, foreign_key: true
  end
end
