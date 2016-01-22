class Roles < ActiveRecord::Migration
  def up
    remove_column :users, :is_employee, default: false
    remove_column :users, :is_admin, default: false
    add_column :users, :role, :string, default: "Recipient"
  end

  def down
    remove_column :users, :role, :string
    add_column :users, :is_admin, default: false
    add_column :users, :is_employee, default: false
  end
end
