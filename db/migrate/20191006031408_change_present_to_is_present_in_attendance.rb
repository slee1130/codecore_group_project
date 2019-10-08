class ChangePresentToIsPresentInAttendance < ActiveRecord::Migration[6.0]
  def change
    rename_column :attendances, :present, :is_present
  end
end
