class AddIsAdminToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_admin, :boolean, index: false
  end
end
