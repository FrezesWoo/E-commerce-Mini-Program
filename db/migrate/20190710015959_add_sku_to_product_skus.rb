class AddSkuToProductSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :product_skus, :sku, :string, null: false
    add_column :product_skus, :d1m_sku, :string
  end
end
