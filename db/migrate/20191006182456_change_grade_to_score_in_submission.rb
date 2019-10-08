class ChangeGradeToScoreInSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :score, :integer, index: false
    remove_column :submissions, :grade
  end
end
