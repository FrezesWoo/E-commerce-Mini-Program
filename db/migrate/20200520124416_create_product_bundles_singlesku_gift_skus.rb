class CreateProductBundlesSingleskuGiftSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :product_bundles_singlesku_gift_skus do |t|
      t.references :product_bundle, foreign_key: true
      t.references :product_sku, foreign_key: true
    end
  end
end
