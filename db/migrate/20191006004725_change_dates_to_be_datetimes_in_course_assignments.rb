class ChangeDatesToBeDatetimesInCourseAssignments < ActiveRecord::Migration[6.0]
  def change
    change_column :course_assignments, :assign_date, :datetime
    change_column :course_assignments, :due_date, :datetime
  end
end
