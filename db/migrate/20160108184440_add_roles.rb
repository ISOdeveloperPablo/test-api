class AddRoles < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :is_employee, :boolean, default: false
    add_column :users, :is_activated, :boolean, default: false
  end
end
