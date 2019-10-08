class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.string :status
      t.string :course_type
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
