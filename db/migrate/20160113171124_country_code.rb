class CountryCode < ActiveRecord::Migration
  def up
    add_column :users, :country_code, :string , null: false
    change_column :users, :phone_number, :string, null: false, length: 10
  end
  def down
    change_column :users, :phone_number, :string, null: false
    remove_column :users, :country_code
  end
end
