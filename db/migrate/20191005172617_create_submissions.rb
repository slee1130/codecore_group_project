class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.string :grade
      t.date :submission_date
      t.timestamps
    end
  end
end
