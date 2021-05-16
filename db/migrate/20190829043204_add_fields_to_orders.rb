class AddFieldsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :has_gift_message, :boolean, default: false
    add_column :orders, :gift_message, :text
  end
end
