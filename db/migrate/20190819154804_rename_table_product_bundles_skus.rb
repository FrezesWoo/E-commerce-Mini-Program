class RenameTableProductBundlesSkus < ActiveRecord::Migration[5.2]
  def change
    rename_table :product_bundles_skus, :product_bundles_product_skus
  end
end
