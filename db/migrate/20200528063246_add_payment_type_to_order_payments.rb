class AddPaymentTypeToOrderPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :order_payments, :payment_type, :integer, default: 0
  end
end
