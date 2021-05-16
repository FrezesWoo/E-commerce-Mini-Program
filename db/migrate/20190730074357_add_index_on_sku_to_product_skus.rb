class AddIndexOnSkuToProductSkus < ActiveRecord::Migration[5.2]
  def change
    add_index :product_skus, :sku
  end
end
