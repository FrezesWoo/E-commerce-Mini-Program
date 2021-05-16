class AddLogiNameOrderSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :shipping_company, :string, default: 'SF'
    add_column :order_skus, :shipping_company, :string, default: 'SF'
    add_column :order_bundles, :shipping_company, :string, default: 'SF'
  end
end
