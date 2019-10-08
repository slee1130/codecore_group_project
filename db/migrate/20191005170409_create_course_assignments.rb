class CreateCourseAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :course_assignments do |t|
      t.date :assign_date
      t.date :due_date
      t.boolean :is_active

      t.timestamps
    end
  end
end
