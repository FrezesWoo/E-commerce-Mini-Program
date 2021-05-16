class AddLimitedProductToProductSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :product_skus, :limited_product, :boolean, default: false
  end
end
