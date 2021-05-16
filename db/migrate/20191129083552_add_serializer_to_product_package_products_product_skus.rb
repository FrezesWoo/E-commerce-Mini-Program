class AddSerializerToProductPackageProductsProductSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :product_package_products_product_skus, :id, :serial, null: false, unique: true, primary_key: true
    rename_table :product_package_products_product_skus, :product_package_product_skus
  end
end
