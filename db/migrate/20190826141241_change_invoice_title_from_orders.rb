class ChangeInvoiceTitleFromOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :invoice_title, :string
  end
end
