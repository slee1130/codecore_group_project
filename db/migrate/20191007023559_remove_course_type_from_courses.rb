class RemoveCourseTypeFromCourses < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :course_type
  end
end
