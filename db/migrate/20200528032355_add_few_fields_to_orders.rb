class AddFewFieldsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :douyin_customer, foreign_key: true
    add_column :orders, :source, :integer, default: 0
  end
end