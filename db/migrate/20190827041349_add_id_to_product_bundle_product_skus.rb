class AddIdToProductBundleProductSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :product_bundles_product_skus, :id, :serial, null: false, unique: true, primary_key: true
  end
end
