class AddMaximumScoreToCourseAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :course_assignments, :maximum_score, :integer, index: false
  end
end
