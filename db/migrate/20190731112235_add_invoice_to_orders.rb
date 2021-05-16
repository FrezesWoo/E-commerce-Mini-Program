class AddInvoiceToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :name, :string
    add_column :orders, :zip, :integer
    add_column :orders, :mobile, :string
    add_column :orders, :invoice_title, :integer
    add_column :orders, :tax_number, :string
    add_column :orders, :email, :string
  end
end
