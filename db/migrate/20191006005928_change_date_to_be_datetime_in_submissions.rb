class ChangeDateToBeDatetimeInSubmissions < ActiveRecord::Migration[6.0]
  def change
    change_column :submissions, :submission_date, :datetime
  end
end
