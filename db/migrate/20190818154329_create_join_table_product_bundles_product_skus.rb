class CreateJoinTableProductBundlesProductSkus < ActiveRecord::Migration[5.2]
  def change
    create_join_table :product_skus, :product_bundles do |t|
      # t.index [:product_sku_id, :product_bundle_id]
      # t.index [:product_bundle_id, :product_sku_id]
    end
  end
end
