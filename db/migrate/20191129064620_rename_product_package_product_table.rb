class RenameProductPackageProductTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :product_packages_products, :product_package_products
    rename_table :product_packages_products_skus, :product_package_products_product_skus
    rename_column :product_package_products_product_skus, :product_packages_product_id, :product_package_product_id
  end
end
