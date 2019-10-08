class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.boolean :present

      t.timestamps
    end
  end
end
