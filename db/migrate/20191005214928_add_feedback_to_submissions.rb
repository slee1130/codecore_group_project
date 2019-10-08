class AddFeedbackToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :feedback, :text, index: false
  end
end
