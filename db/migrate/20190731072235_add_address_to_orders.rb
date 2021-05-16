class AddAddressToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :province, :string
    add_column :orders, :city, :string
    add_column :orders, :address, :string
    add_column :orders, :area, :string
    add_column :orders, :need_invoice, :boolean
  end
end
