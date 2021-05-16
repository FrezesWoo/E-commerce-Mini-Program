class AddShippingNumberToOrderSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :order_skus, :shipping_number, :string
  end
end
