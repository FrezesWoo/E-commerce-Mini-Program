class ChangeProductBundleProductSkuConditionsProductBundles < ActiveRecord::Migration[5.2]
  def change
    remove_column :product_bundles, :product_sku_id
    add_reference :product_bundles, :product, index: true
  end
end
