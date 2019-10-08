class AddIsArchivedToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :is_archived, :boolean, index: false
  end
end
