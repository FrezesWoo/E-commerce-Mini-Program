class RenameProductBundlesSingleskuGiftSkusTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :product_bundles_singlesku_gift_skus, :product_bundles_gift_skus
  end
end
