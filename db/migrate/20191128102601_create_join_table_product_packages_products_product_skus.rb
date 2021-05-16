class CreateJoinTableProductPackagesProductsProductSkus < ActiveRecord::Migration[5.2]
  def change
    create_join_table :product_packages_products, :product_skus do |t|
      # t.index [:product_packages_product_id, :product_sku_id]
      # t.index [:product_sku_id, :product_packages_product_id]
    end
  end
end
