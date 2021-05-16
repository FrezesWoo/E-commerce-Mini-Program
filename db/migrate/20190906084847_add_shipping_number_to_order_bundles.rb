class AddShippingNumberToOrderBundles < ActiveRecord::Migration[5.2]
  def change
    add_column :order_bundles, :shipping_number, :string
    add_column :order_bundles, :quantity, :integer, default: 0
  end
end
