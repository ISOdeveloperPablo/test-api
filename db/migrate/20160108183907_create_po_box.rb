class CreatePoBox < ActiveRecord::Migration
  def change
    create_table :po_boxes do |t|
      t.string :box_number, null: false
      t.string :city, null: false
      t.string :country, null: false
    end
  end
end
