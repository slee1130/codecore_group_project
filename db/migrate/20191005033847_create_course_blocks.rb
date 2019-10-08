class CreateCourseBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :course_blocks do |t|
      t.date :date
      t.string :course_block_type

      t.timestamps
    end
  end
end
