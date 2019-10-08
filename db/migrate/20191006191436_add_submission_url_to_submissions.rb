class AddSubmissionUrlToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :submission_url, :string, index: false
  end
end
